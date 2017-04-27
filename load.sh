#!/bin/bash

TABLES="agency calendar calendar_dates routes shapes stop_times stops trips transfers frequencies feed_info fare_attributes fare_rules"

# takes two arguments
# A zip file containing gtfs files:
ZIP=$1
# Second, set of psql flags
PSQLFLAGS=${*/$1/ }

FILES=$(unzip -l "${ZIP}" | awk '{print $NF}' | grep .txt)

# Called with name of table
function import_stdin()
{
    local hed
    hed=$(unzip -p "$ZIP" "${1}.txt" | head -n 1)
    echo "COPY gtfs_${1}" 1>&2
    unzip -p "$ZIP" "${1}.txt" | psql ${PSQLFLAGS} -c "COPY gtfs_${1} (${hed}) FROM STDIN WITH DELIMITER AS ',' HEADER CSV"
}

# Insert feed info
if [[ "${FILES/feed_info}" != "$FILES" ]]; then
    # Contains feed info, so load that into the table
    import_stdin "feed_info"
else
    # get the min and max calendar dates for this
    start_date=$(unzip -p "$ZIP" calendar.txt | python -c "import csv, sys; print(min(row['start_date'] for row in csv.DictReader(sys.stdin)))")
    end_date=$(unzip -p "$ZIP" calendar.txt | python -c "import csv, sys; print(max(row['end_date'] for row in csv.DictReader(sys.stdin)))")
    echo "INSERT INTO gtfs_feed_info" 1>&2
    psql ${PSQLFLAGS} -c "INSERT INTO gtfs_feed_info (feed_start_date, feed_end_date) VALUES ('${start_date}'::date, '${end_date}'::date);"
fi

# Save the current feed_index
feed_index=$(psql ${PSQLFLAGS} --pset format=unaligned -t -c "SELECT max(feed_index) FROM gtfs_feed_info")

echo "SET feed_index = $feed_index" 1>&2

# for each table, check if file exists
for table in $TABLES; do
    if [[ ${FILES/$table} != "$FILES" ]]; then
        # set default feed_index
        psql ${PSQLFLAGS} -c "ALTER TABLE gtfs_${table} ALTER COLUMN feed_index SET DEFAULT ${feed_index}"

        # read it into db
        import_stdin "$table"

        # unset default feed_index
        psql ${PSQLFLAGS} -c "ALTER TABLE gtfs_${table} ALTER COLUMN feed_index DROP DEFAULT"
    fi
done
