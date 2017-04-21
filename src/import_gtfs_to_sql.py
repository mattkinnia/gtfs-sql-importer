#!/usr/bin/env python

# Copyright (c) 2010 Colin Bick, Robert Damphousse

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
import os

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


def import_file(directory, name):
    """Returns SQL statement iterator"""
    delim = ","
    absfile = os.path.abspath(os.path.join(directory, name + ".txt"))

    try:
        with open(absfile, 'r') as f:
            cols = f.readline().strip()
            return "COPY gtfs_{} ({}) FROM '{}' WITH NULL AS '\\N' DELIMITER AS '{}' HEADER CSV;".format(name, cols, absfile, delim)

    except IOError:
        print("-- file %s doesn't exist" % name, file=sys.stderr)


def update_feed_info(directory):
    if os.path.exists(os.path.join(directory, 'feed_info.txt')):
        name = os.path.join(directory, 'feed_info.txt')
        return import_file(directory, name)

    else:
        return "INSERT INTO gtfs_feed_info (feed_version) VALUES ('" + directory + "');"

if __name__ == "__main__":
    if len(sys.argv) not in (2, 3):
        print("Usage: %s gtfs_data_dir" % sys.argv[0])
        sys.exit()

    # Check for feed_info. If it doesn't exist, create a dummy version. Temporarily set defaults on feed_index columns
    finfo = update_feed_info(sys.argv[1])
    print(finfo)
    print(finfo, file=sys.stderr)

    for fname in TABLES:
        statement = import_file(sys.argv[1], fname)
        if statement:
            print(statement, file=sys.stderr)
            print(statement)
