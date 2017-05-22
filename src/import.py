#!/usr/bin/env python

# Copyright (c) 2017 Neil Freeman

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
from __future__ import print_function
import sys
from zipfile import ZipFile
import psycopg2

TABLES = [
    "agency",
    "calendar",
    "stops",
    "routes",
    "calendar_dates",
    "fare_attributes",
    "fare_rules",
    "shapes",
    "trips",
    "stop_times",
    "frequencies",
    "transfers",
    ]

alter = 'ALTER TABLE gtfs_{} ALTER COLUMN feed_index SET DEFAULT %(index)s'
reset = 'ALTER TABLE gtfs_{} ALTER COLUMN feed_index DROP DEFAULT'


def set_defaults(cursor):
    cursor.execute('SELECT MAX(feed_index) FROM gtfs_feed_info')
    index = cursor.fetchone()[0]
    query = ';'.join(alter.format(t) for t in TABLES)
    cursor.execute(query, {'index': index})

def reset_defaults(cursor):
    query = ';'.join(reset.format(t) for t in TABLES)
    cursor.execute(query)

def copy_from(f, cursor, name):
    cols = ','.join(x.strip('"\'\r\n ') for x in f.readline().split(','))
    copy = "COPY {0} ({1}) FROM STDIN WITH CSV DELIMITER ',' QUOTE '\"' NULL AS ''"
    cursor.copy_expert(copy.format('gtfs_' + name, cols), f)


def main(archive, connstring):
    with ZipFile(archive) as z:
        with psycopg2.connect(connstring) as conn:
            with conn.cursor() as cursor:
                # Check for feed_info. If it doesn't exist, create a dummy version.
                try:
                    with z.open('feed_info.txt', 'rU') as f:
                        copy_from(f, cursor, 'feed_info')

                except KeyError:
                    insert = 'INSERT INTO gtfs_feed_info (feed_version) VALUES (%s)'
                    cursor.execute(insert, (archive,))

                set_defaults(cursor)

                for fname in TABLES:
                    try:
                        with z.open(fname + '.txt', 'rU') as f:
                            copy_from(f, cursor, fname)
                            print("inserted into", fname, file=sys.stderr)
                    except KeyError:
                        pass

                reset_defaults(cursor)
            conn.commit()

if __name__ == "__main__":
    if len(sys.argv) not in (3, 4):
        print("Usage: %s <gtfs.zip> <connstring>" % sys.argv[0])
        sys.exit()

    main(sys.argv[1], sys.argv[2])
