/*
Arguments
---------
:schema: typically `gtfs`
:feed_index: A feed index to check
*/
SET search_path TO tap, :schema, public;

SELECT plan(1);

SELECT set_eq(
  format('SELECT DISTINCT trip_id
    FROM (
      SELECT
        feed_index,
        trip_id,
        stop_id,
        stop_sequence,
        coalesce(lag(shape_dist_traveled) over (trip), 0) AS lag,
        shape_dist_traveled AS dist,
        (lead(shape_dist_traveled) over (trip)) AS lead
      FROM stop_times
      WHERE feed_index = %s
      WINDOW trip AS (PARTITION BY feed_index, trip_id ORDER BY stop_sequence)
    ) AS d
      LEFT JOIN trips trip USING (feed_index, trip_id)
      LEFT JOIN shape_geoms shape USING (feed_index, shape_id)
    WHERE COALESCE(lead, length) > lag AND (dist > COALESCE(lead, length) OR dist < lag)',
    :feed_index
  ),
  ARRAY[]::text[],
  'No trips with out-of-order stops'
);

SELECT * FROM finish();
