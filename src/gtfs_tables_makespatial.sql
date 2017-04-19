begin;

create table gtfs_shape_lengths as
select shape_id, st_length(st_transform(the_geom, 2163)) as shape_dist from gtfs_shape_geoms;

commit;

  -- This script uses PostGIS to fill in the shape_dist_traveled field using stop and shape geometries. 
  -- It assumes that gtfs_tables_makespatial.sql has been run to build said geometries.

  -- Create a table that contains stop distances along trip patterns, assuming that a pattern consists of
  -- (a.route_id, direction_id, shape_id)
  -- this is far more efficient than doing the geometry processing on every row in stop_times

drop table if exists gtfs_stop_distances_along_shape;
drop table if exists gtfs_distinct_patterns;

begin;

CREATE TABLE gtfs_distinct_patterns AS
SELECT distinct t.route_id, t.direction_id, t.shape_id, st.stop_sequence, st.stop_id
FROM gtfs_stop_times st
INNER JOIN gtfs_trips t on st.trip_id = t.trip_id;

CREATE TABLE gtfs_stop_distances_along_shape AS
SELECT a.route_id,
    direction_id,
    shape_id,
    stop_sequence,
    stop_id,
    round(cast(ST_LineLocatePoint(route.the_geom, stop.the_geom) as numeric), 3) AS pct_along_shape, 
    ST_LineLocatePoint(route.the_geom, stop.the_geom) * st_length_spheroid(route.the_geom, 'SPHEROID["GRS_1980",6378137,298.257222101]') as dist_along_shape
FROM gtfs_distinct_patterns a
LEFT JOIN gtfs_shape_geoms AS route USING (shape_id)
LEFT JOIN gtfs_stops as stop USING (stop_id); 

commit;

begin;
  -- Use this table to create a second gtfs_stop_times table, using key above
drop table IF EXISTS gtfs_stop_times2 cascade;
commit;

begin;
create table gtfs_stop_times2 as
select st.trip_id,
    st.arrival_time,
    st.departure_time,
    st.stop_id,
    st.stop_sequence,
    a.dist_along_shape AS shape_dist_traveled
FROM gtfs_stop_distances_along_shape AS a
join gtfs_stop_times st on st.stop_id = a.stop_id
join gtfs_trips t on st.trip_id = t.trip_id
where
      a.route_id = t.route_id
    and a.direction_id= t.direction_id
    and a.shape_id = t.shape_id 
    and st.stop_sequence = a.stop_sequence
    and a.stop_id = st.stop_id; 

commit;

