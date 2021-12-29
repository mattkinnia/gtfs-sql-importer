SET search_path TO tap, :schema, public;

SELECT plan(2);

SELECT set_eq(
  format('SELECT distinct stop_id
  FROM stop_times a
    LEFT JOIN stops b USING (feed_index, stop_id)
  WHERE b.stop_id IS NULL
    AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'stop_times_stops_fkey would be valid'
);

SELECT set_eq(
  format('SELECT distinct trip_id
  FROM stop_times a
    LEFT JOIN trips b USING (feed_index, trip_id)
  WHERE b.trip_id IS NULL
    AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'stop_times_trips_fkey would be valid'
);

SELECT * from finish();