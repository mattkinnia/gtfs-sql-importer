/*
Check that required tables aren't empty for the given feed_index
Arguments
---------
:schema: typically `gtfs`
:feed_index: A feed index to check
*/
SET search_path TO tap, public;
SELECT plan(20);

SELECT isnt_empty(
  format('SELECT FROM %I.%I WHERE feed_index = %s', :'schema', table_name, :feed_index),
  table_name || ' has data for feed_index = ' || :'feed_index'
 ) FROM unnest(ARRAY[
  'feed_info',
  'agency',
  'routes',
  'stops',
  'trips',
  'stop_times'
 ]) table_name;

SELECT collect_tap(
  ok(feed_end_date is not null, 'feed_info.feed_end_date exists for feed_index = '||  :'feed_index'),
  ok(feed_start_date is not null, 'feed_info.feed_start_date exists for feed_index = ' || :'feed_index')
  )
  FROM :schema.feed_info WHERE feed_index = :feed_index;

-- These tables are optional or only conditionally required
SELECT todo(12);
SELECT isnt_empty(
  format('SELECT FROM %I.%I WHERE feed_index = %s', :'schema', table_name, :feed_index),
  table_name || ' has data for feed_index = ' || :'feed_index'
 ) FROM unnest(ARRAY[
  'calendar',
  'calendar_dates',
  'fare_attributes',
  'fare_rules',
  'shapes',
  'shape_geoms',
  'frequencies',
  'transfers',
  'pathways',
  'levels',
  'translations',
  'attributions'
 ]) table_name;

SELECT * FROM finish();
