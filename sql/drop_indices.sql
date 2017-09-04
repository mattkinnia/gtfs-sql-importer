ALTER TABLE gtfs_agency
  DROP CONSTRAINT gtfs_agency_pkey CASCADE;

ALTER TABLE gtfs_calendar
  DROP CONSTRAINT gtfs_calendar_pkey CASCADE;
DROP INDEX gtfs_calendar_service_id;

ALTER TABLE gtfs_stops
  DROP CONSTRAINT gtfs_stops_pkey CASCADE;

ALTER TABLE gtfs_routes
  DROP CONSTRAINT gtfs_routes_pkey CASCADE;

DROP INDEX gtfs_calendar_dates_dateidx;

ALTER TABLE gtfs_fare_attributes
  DROP CONSTRAINT gtfs_fare_attributes_pkey CASCADE;

DROP INDEX gtfs_shapes_shape_key;

ALTER TABLE gtfs_trips
  DROP CONSTRAINT gtfs_trips_pkey CASCADE;
DROP INDEX gtfs_trips_service_id;

ALTER TABLE gtfs_stop_times
  DROP CONSTRAINT gtfs_stop_times_pkey CASCADE;
DROP INDEX gtfs_stop_times_key;

DROP INDEX arr_time_index;
DROP INDEX dep_time_index;

ALTER TABLE gtfs_shape_geoms
  DROP CONSTRAINT gtfs_shape_geom_pkey CASCADE;

ALTER TABLE gtfs_frequencies
  DROP CONSTRAINT gtfs_frequencies_pkey CASCADE;
