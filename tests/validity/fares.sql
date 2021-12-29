SET search_path TO tap, :schema, public;

SELECT plan(4);

SELECT set_eq(
  format(
    'SELECT distinct agency_id
    FROM fare_attributes a LEFT JOIN agency b USING (feed_index, agency_id)
    WHERE b.agency_id IS NULL AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'fare_attributes_fkey would be valid'
);

SELECT set_eq(
    format('SELECT distinct service_id
    FROM fare_rules a LEFT JOIN calendar b USING (feed_index, service_id)
    WHERE b.service_id IS NULL AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'fare_rules_service_fkey would be valid'
);

SELECT set_eq(
    format('SELECT distinct route_id
    FROM fare_rules a
      LEFT JOIN routes b USING (feed_index, route_id)
    WHERE b.route_id IS NULL
      AND feed_index = %s',
      :feed_index
    ),
  ARRAY[]::text[],
  'fare_rules_route_id_fkey would be valid'
);

SELECT set_eq(
    format(
        'SELECT distinct fare_id
        FROM fare_rules a LEFT JOIN fare_attributes b USING (feed_index, fare_id)
        WHERE b.fare_id IS NULL AND feed_index = %s',
      :feed_index
    ),
    ARRAY[]::text[],
    'fare_rules_fare_id_fkey would be valid'
);

SELECT * FROM finish();