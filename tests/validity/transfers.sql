SET search_path TO tap, :schema, public;

SELECT plan(4);

SELECT set_eq(
  format('SELECT distinct from_stop_id
  FROM transfers a
    LEFT JOIN stops b on a.feed_index = b.feed_index and a.from_stop_id::text = b.stop_id::text
  WHERE b.stop_id IS NULL
    AND a.feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'transfers_from_stop_fkey would be valid');

SELECT set_eq(
  format('SELECT distinct to_stop_id
  FROM transfers a
    LEFT JOIN stops b on a.feed_index = b.feed_index and a.to_stop_id::text = b.stop_id::text
  WHERE b.stop_id IS NULL
    AND a.feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'transfers_to_stop_fkey would be valid');

SELECT set_eq(
  format('SELECT distinct from_route_id
  FROM transfers a
    LEFT JOIN routes b on a.feed_index = b.feed_index and a.from_route_id::text = b.route_id::text
  WHERE b.route_id IS NULL
    AND a.feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'transfers_from_route_fkey would be valid');

SELECT set_eq(
  format('SELECT distinct to_route_id
  FROM transfers a
    LEFT JOIN routes b on a.feed_index = b.feed_index and a.to_route_id::text = b.route_id::text
  WHERE b.route_id IS NULL
    AND a.feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'transfers_to_route_fkey would be valid');

SELECT * from finish();
