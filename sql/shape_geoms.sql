BEGIN;

INSERT INTO gtfs_shape_geoms (feed_index, shape_id, the_geom)
SELECT
  feed_index,
  shape_id,
  ST_SetSRID(ST_MakeLine(ST_MakePoint(shape_pt_lon, shape_pt_lat)), 4326) AS the_geom
FROM (
  SELECT * FROM gtfs_shapes ORDER BY shape_id, shape_pt_sequence
) shape
WHERE shape.feed_index = (SELECT MAX(feed_index) FROM gtfs_feed_info)
GROUP BY feed_index, shape_id;

-- This script uses PostGIS to fill in the shape_dist_traveled field using stop and shape geometries. 
-- It assumes that gtfs_tables_makespatial.sql has been run to build said geometries.

-- Create a table that contains stop distances along trip patterns, assuming that a pattern consists of
-- (a.route_id, direction_id, shape_id)
-- this is far more efficient than doing the geometry processing on every row in stop_times

INSERT INTO gtfs_stop_distances_along_shape
  (feed_index, route_id, direction_id, shape_id, stop_id, stop_sequence, pct_along_shape, dist_along_shape)
SELECT DISTINCT
  feed_index,
  shape_id,
  stop_id,
  ROUND(CAST(ST_LineLocatePoint(route.the_geom, stop.the_geom) as numeric), 3) AS pct_along_shape,
  ROUND(CAST(ST_LineLocatePoint(route.the_geom, stop.the_geom) * ST_length_spheroid(
    route.the_geom, 'SPHEROID["WGS 84",6378137,298.257223563]'
  ) as NUMERIC), 1) as dist_along_shape
FROM
  (
    SELECT DISTINCT
      feed_index, shape_id, stop_id
    FROM gtfs_stop_times st
      LEFT JOIN gtfs_trips t USING (feed_index, trip_id)
    WHERE feed_index = (SELECT MAX(feed_index) FROM gtfs_feed_info)
  ) a
  LEFT JOIN gtfs_shape_geoms AS route USING (feed_index, shape_id)
  LEFT JOIN gtfs_stops as stop USING (feed_index, stop_id);
