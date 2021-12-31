/*
Update the stop_times.shape_dist_traveled column where missing or out-of-order.
Arguments
---------
:schema: database schema, typically `gtfs`
:feed_file: the feed zip file, should be a unique row in :schema.feed_info
:srid: the spatial reference system to work in. Using a projected system will improve results.
  Use a system that employs meters
*/
UPDATE :schema.stop_times s
  SET shape_dist_traveled = :schema.safe_locate(
    ST_Transform(r.the_geom, :srid),
    ST_Transform(p.the_geom, :srid),
    lag,
    coalesce(lead, r.length),
    r.length::numeric
  )
FROM
  (
    SELECT
      feed_index,
      trip_id,
      stop_id,
      coalesce(lag(shape_dist_traveled) over (trip), 0)::numeric AS lag,
      shape_dist_traveled AS dist,
      lead(shape_dist_traveled) over (trip)::numeric AS lead
    FROM :schema.stop_times
      JOIN :schema.feed_info USING (feed_index)
    WHERE feed_file = :'feed_file'
    WINDOW trip AS (PARTITION BY feed_index, trip_id ORDER BY stop_sequence)
  ) AS d
  LEFT JOIN :schema.stops AS p USING (feed_index, stop_id)
  LEFT JOIN :schema.trips AS t USING (feed_index, trip_id)
  LEFT JOIN :schema.shape_geoms AS r USING (feed_index, shape_id)
WHERE
  (s.feed_index, s.trip_id, s.stop_id) = (d.feed_index, d.trip_id, d.stop_id)
  AND (
    COALESCE(lead, length) > lag
    AND (dist > COALESCE(lead, length) OR dist < lag)
  )
  OR s.shape_dist_traveled IS NULL;
