SET search_path TO tap, :schema, public;

SELECT plan(1);

SELECT set_eq(
  format('SELECT distinct service_id
  FROM trips a LEFT JOIN calendar b USING (feed_index, service_id)
  WHERE b.service_id IS NULL AND feed_index = %s',
  :feed_index
  ),
  ARRAY[]::text[]);

SELECT * FROM finish();
