SET search_path TO tap, :schema, public;

SELECT plan(1);

SELECT set_eq(
  format('SELECT distinct trip_id
  FROM frequencies a
    LEFT JOIN trips b USING (feed_index, trip_id)
  WHERE b.trip_id IS NULL
    AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[]);

SELECT * FROM finish();