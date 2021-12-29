# About

Import GTFS data into a PostgreSQL database. Includes all the constraints in the GTFS spec with some basic tools for dealing with improper data

## Requirements

* Postgresql database (10+) with a PostGIS (2.2+) extension

## Links

* [GTFS (General Transit Feed Specification)](https://gtfs.org/reference/static)
* [Transitfeeds](http://transitfeeds.com) (index and archive of GTFS data sets)
* [Transit.land](http://transit.land) A community-edited service with an achive of GTFS.

## Initial import

This importer uses a Makefile to organize a series of SQL commands. The file `src/load.sh` is a shell script that does the heavy lifting of loading the contents of a GTFS zip file into a PostgreSQL database.

Before importing data, set up database with:
```
export PGDATABASE=mydbname
make init
```
This will create the necessary tables, as well as useful indices and foreign keys. (It will create a database named `mydbname` if one does not exist).

Next, download a ZIP file containing a GTFS feed. You do not need to decompress it to import it.

To import the GTFS dataset in file named `gtfs.zip` into a local Postgres database named `mydbname`:
````
make load GTFS=gtfs.zip
````

## Connecting to the db

Use the standard [Postgres environment variables](https://www.postgresql.org/docs/current/static/libpq-envars.html) to specify your connection parameters. For example:
````
export PGDATABASE=mydbname PGHOST=example.com PGUSER=username
make load GTFS=gtfs.zip
````

If you're connecting over the socket, and your postgres username and database match your system username, you don't have to use environment variables.

### Schema

By default, your GTFS data will be loaded into a schema named `gtfs`. You can always rename it when you're done. Setting the `SCHEMA` variable when running make tasks will also address a different schema

## Big datasets

For large feeds, you may find that loading is faster with indices. Don't forget to add them back, or all your queries will be very slow:
````
make drop_indices load add_indices GTFS=gtfs.zip
````

## Feed indexes

GTFS data is regularly updated, and it's reasonable to want to include multiple iterations in the same database. This tool includes a `feed_index` column in each table. This index is part of the primary key of each table.

## Troubleshooting common errors in GTFS data

Most GTFS data has errors in it, so you may encounter an error when running the step above.
Common errors include missing `service_id`s, which cause foreign key errors. To load data despite these violations, remove contraints with `make drop_constraints`. Then load the data and try repair the data. When you're ready, restore the constraints with `make add_constraints`.

### General validity checking

The `check` task will run the scripts in `tests/validity`, which will perform several queries looking for rows that violate foreign key constraints and bad geometries in the `shapes` table. These tests require `prove`, a very common perl testing program and [pgTAP](https://pgtap.org), a Postgresql testing suite. Install it in a new `tap` schema with:
```bash
wget https://api.pgxn.org/dist/pgtap/1.2.0/pgtap-1.2.0.zip
unzip pgtap-1.2.0.zip
make -C pgtap-1.2.0 sql/pgtap.sql
PGOPTIONS=--search_path=tap,public psql -c "CREATE SCHEMA tap" -f pgtap-1.2.0/sql/pgtap.sql
```
Then run the check task, giving the index of the feed to check:
```
make check FEED_INDEX=1
```

The resulting report will tell you which tables have constraint violations, and what the errors are. You may wish to manually add missing values to your tables.

If you don't have `prove` available, try another [TAP consumer](http://testanything.org/consumers.html). Failing that, you can run the tests with:
```bash
find tests -name '*.sql' -print -exec psql -Aqt -v schema=gtfs -f {} \;
```

### Extra columns

The loading script checks for extra columns in a GTFS table and adds them to database as `text` columns. You may wish to alter or remove these columns.

### Null data
```
ERROR:  null value in column "example_id" violates not-null constraint
```
This might occur if an "id" column (e.g. `route_id`) is improperly empty. One solution: edit the file to add a non-empty value.
Another solution: drop indices from the database and reload the data:
```
make drop_indices load
```
Then edit the database to add a non-empty value and recreate the indices (`make add_indices`).

# License
Released under the MIT (X11) license. See LICENSE in this directory.
