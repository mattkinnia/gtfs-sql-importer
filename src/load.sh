#!/bin/bash
set -e
# This script takes three arguments: 
# - A zip file containing gtfs files
# - schema namem, typically `gtfs`
# - table name, which should refer to a file named table.txt in the zip archive
ZIP=$1
SCHEMA=${2}
TABLE=${3}

if [[ -z "$(unzip -Z -1 "$ZIP" "${TABLE}.txt")" ]]; then
    echo "Skipping ${SCHEMA}.${TABLE}" 1>&2
    exit
fi

# Die if this zip isn't yet registered in feed_info
feed_index=$(psql -At -c "SELECT feed_index FROM ${SCHEMA}.feed_info WHERE feed_file = '${ZIP}'")
if [[ -z "$feed_index" ]]; then
    echo "Unable to find '${ZIP}' in ${SCHEMA}.feed_info" 1>&2
    exit 1
fi

export PGOPTIONS="${PGOPTIONS} -c client_min_messages=warning"

# Remove possible BOM from header
hed=$(unzip -p "$ZIP" "${TABLE}.txt" | head -n 1 | sed 's/^\xEF\xBB\xBF//')

# Add unknown custom columns as text fields
echo "$hed" \
| awk -v schema="$SCHEMA" -v FS=, -v table="$TABLE" '{for (i = 1; i <= NF; i++) print "ALTER TABLE " schema "." table " ADD COLUMN IF NOT EXISTS " $i " TEXT;"}' \
| psql -q

# COPY rows from zip file, removing leading spaces and other junk
unzip -p "$ZIP" "${TABLE}.txt" \
| tail -n +2 \
| awk -v fi="${feed_index}" '{ sub(/\r$/, ""); sub("^\"\",", ","); gsub(",\"\"", ","); gsub(/,[[:space:]]+/, ","); if (NF > 0) print fi "," $0 }' \
| psql -c "COPY ${SCHEMA}.${TABLE} (feed_index, ${hed}) FROM STDIN (FORMAT csv, HEADER off)"
