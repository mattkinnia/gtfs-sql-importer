SET search_path TO tap, :schema, public;
SELECT plan(2);

SELECT set_eq(
  format('SELECT distinct service_id
  FROM calendar_dates
    LEFT JOIN calendar b USING (feed_index, service_id)
  WHERE b.service_id IS NULL
    AND feed_index = %s',
    :feed_index
  ),
  ARRAY[]::text[],
  'calendar_dates_service_id_fkey would be valid'
);

SELECT set_eq(
  format('SELECT distinct service_id
  FROM trips a LEFT JOIN calendar b USING (feed_index, service_id)
  WHERE b.service_id IS NULL AND feed_index = %s',
  :feed_index
  ),
  ARRAY[]::text[],
  'trips_calendar_fkey would be valid'
);

SELECT * FROM finish();
