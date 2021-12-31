SET search_path TO tap, :schema, public;
SELECT plan(1);

SELECT set_eq(
  format('SELECT distinct route_id
  FROM trips a LEFT JOIN routes b USING (feed_index, route_id)
  WHERE b.route_id IS NULL AND feed_index = %s',
  :feed_index
  ),
  ARRAY[]::text[],
  'trips_route_id_fkey would be valid'
);

SELECT * from finish();