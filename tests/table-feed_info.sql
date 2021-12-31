BEGIN;
SET search_path TO tap, public;
SELECT plan(29);
SELECT has_table(:'schema', 'feed_info', 'table feed_info exists');
SELECT has_pk(:'schema', 'feed_info', 'table feed_info has primary key');
SELECT has_column(:'schema', 'feed_info', 'feed_index', 'table feed_info has column feed_index');
SELECT col_type_is(:'schema', 'feed_info', 'feed_index', 'integer', 'column feed_info.feed_index is integer');
SELECT has_column(:'schema', 'feed_info', 'feed_publisher_name', 'table feed_info has column feed_publisher_name');
SELECT col_type_is(:'schema', 'feed_info', 'feed_publisher_name', 'text', 'column feed_info.feed_publisher_name is text');
SELECT has_column(:'schema', 'feed_info', 'feed_publisher_url', 'table feed_info has column feed_publisher_url');
SELECT col_type_is(:'schema', 'feed_info', 'feed_publisher_url', 'text', 'column feed_info.feed_publisher_url is text');
SELECT has_column(:'schema', 'feed_info', 'feed_timezone', 'table feed_info has column feed_timezone');
SELECT col_type_is(:'schema', 'feed_info', 'feed_timezone', 'text', 'column feed_info.feed_timezone is text');
SELECT has_column(:'schema', 'feed_info', 'feed_lang', 'table feed_info has column feed_lang');
SELECT col_type_is(:'schema', 'feed_info', 'feed_lang', 'text', 'column feed_info.feed_lang is text');
SELECT has_column(:'schema', 'feed_info', 'feed_version', 'table feed_info has column feed_version');
SELECT col_type_is(:'schema', 'feed_info', 'feed_version', 'text', 'column feed_info.feed_version is text');
SELECT has_column(:'schema', 'feed_info', 'feed_start_date', 'table feed_info has column feed_start_date');
SELECT col_type_is(:'schema', 'feed_info', 'feed_start_date', 'date', 'column feed_info.feed_start_date is date');
SELECT has_column(:'schema', 'feed_info', 'feed_end_date', 'table feed_info has column feed_end_date');
SELECT col_type_is(:'schema', 'feed_info', 'feed_end_date', 'date', 'column feed_info.feed_end_date is date');
SELECT has_column(:'schema', 'feed_info', 'feed_id', 'table feed_info has column feed_id');
SELECT col_type_is(:'schema', 'feed_info', 'feed_id', 'text', 'column feed_info.feed_id is text');
SELECT has_column(:'schema', 'feed_info', 'feed_contact_url', 'table feed_info has column feed_contact_url');
SELECT col_type_is(:'schema', 'feed_info', 'feed_contact_url', 'text', 'column feed_info.feed_contact_url is text');
SELECT has_column(:'schema', 'feed_info', 'feed_contact_email', 'table feed_info has column feed_contact_email');
SELECT col_type_is(:'schema', 'feed_info', 'feed_contact_email', 'text', 'column feed_info.feed_contact_email is text');
SELECT has_column(:'schema', 'feed_info', 'feed_download_date', 'table feed_info has column feed_download_date');
SELECT col_type_is(:'schema', 'feed_info', 'feed_download_date', 'date', 'column feed_info.feed_download_date is date');
SELECT has_column(:'schema', 'feed_info', 'feed_file', 'table feed_info has column feed_file');
SELECT col_type_is(:'schema', 'feed_info', 'feed_file', 'text', 'column feed_info.feed_file is text');
SELECT col_is_unique(:'schema', 'feed_info', 'feed_file', 'column feed_info.feed_file is unique');
SELECT * FROM finish();
ROLLBACK;
