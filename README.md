# About
Quick & easy import of GTFS data into a SQL database.

* [GTFS (General Transit Feed Specification)](http://code.google.com/transit/spec/transit_feed_specification.html)
* [Transitfeed](http://transitfeeds.com) (index and archive of GTFS data sets)

## Initial Import

This importer uses a Makefile to organize a series of SQL commands. The file `load.sh` is a simple shell script that loads files into an existing PostGreSQL database.

Before importing data, set up database with:
```
make init DATABASE=mydbname
```
This will create the necessary tables, as well as useful indices and foreign keys. (It will create a database named `mydbname` if one does not exist).

Next, download a ZIP file containing a GTFS feed. You do not need to decompress it to import it.

To import the GTFS data set in file names `gtfs_archive.zip` into a Postgres database names `mydbname`:
````
make load GTFS=gtfs_archive.zip DATABASE=mydbname
````

Most GTFS data has errors in it, so you will likely encounter an error when 
running the step above.

After fixing the error by manually correcting the GTFS files, you can simply repeat the command (which will likely break again, and 
so on). 

### Feed indexes

TK: How multiple GTFS feeds are handled

# Test/Demonstration

The corrected (even google's example data has errors) demo feed from the 
GTFS website is included in this distribution. You should play around with that 
first to get everything to work and to see how the data gets put into tables.

From this directory (assuming postgres):

    createdb testgtfs
    cat gtfs_tables.sql \
      <(python import_gtfs_to_sql.py sample_feed) \
      gtfs_tables_makeindexes.sql \
      vacuumer.sql \
    | psql testgtfs
    psql testgtfs -c "\dt"

# License
Released under the MIT (X11) license. See LICENSE in this directory.
