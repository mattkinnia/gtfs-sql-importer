SET search_path TO tap, :schema, public;

SELECT plan(2);

SELECT set_eq(
  format('SELECT DISTINCT route_type
    FROM routes a LEFT JOIN route_types b USING (route_type)
    WHERE a.route_type IS NOT NULL AND b.route_type IS NULL AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::integer[],
  'route_types_fkey would be valid'
);

SELECT set_eq(
  format('SELECT distinct agency_id
  FROM routes a
    LEFT JOIN agency b USING (feed_index, agency_id)
  WHERE b.agency_id IS NULL
    AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[], 'routes_agency_id_fkey would be valid'
);

SELECT * FROM finish();