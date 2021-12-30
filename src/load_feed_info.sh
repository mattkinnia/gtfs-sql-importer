#!/bin/bash
# This script takes three arguments: 
# A zip file containing gtfs files and a schema name.
# It tries to load the file "feed_info.txt" from the zip file. If that file doesn't exist, it inserts a new row with no metadata
ZIP=$1
SCHEMA=${2}

feed_index=$(psql -At -c "SELECT feed_index FROM ${SCHEMA}.feed_info WHERE feed_file = '${ZIP}'")

if [[ -n "$feed_index" ]]; then
    echo "Using existing feed_index = $feed_index"
    exit
fi

export PGOPTIONS="${PGOPTIONS} -c client_min_messages=warning"

if [[ $(unzip -Z -1 "$ZIP" | grep feed_info.txt) ]]; then

    hed=$(unzip -p "$ZIP" feed_info.txt | head -n 1 | awk '{sub(/^\xef\xbb\xbf/,"")}{print}')

    echo "$hed" \
    | awk -v schema=$SCHEMA -v FS=, -v table=feed_info '{for (i = 1; i <= NF; i++) print "ALTER TABLE " schema "." table " ADD COLUMN IF NOT EXISTS " $i " TEXT;"}' \
    | psql -q

    unzip -p "$ZIP" feed_info.txt \
    | awk -v feed_file="$ZIP" '{ sub(/\r$/, ""); sub("^\"\",", ","); gsub(",\"\"", ","); gsub(/,[[:space:]]+/, ","); if (NF > 0) print $0 "," feed_file }' \
    | psql -c "COPY ${SCHEMA}.feed_info (${hed},feed_file) FROM STDIN (FORMAT csv, HEADER on)"

else
    # Start and end dates will be populated after insert to calendar_dates
    psql -c "INSERT INTO ${SCHEMA}.feed_info (feed_file) VALUES ('${ZIP}') ON CONFLICT DO NOTHING";
    
fi
