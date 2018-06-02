ALTER TABLE gtfs.agency
  DROP CONSTRAINT gtfs.agency_pkey CASCADE;

ALTER TABLE gtfs.calendar
  DROP CONSTRAINT gtfs.calendar_pkey CASCADE;
DROP INDEX gtfs.calendar_service_id;

ALTER TABLE gtfs.stops
  DROP CONSTRAINT gtfs.stops_pkey CASCADE;

ALTER TABLE gtfs.routes
  DROP CONSTRAINT gtfs.routes_pkey CASCADE;

DROP INDEX gtfs.calendar_dates_dateidx;

ALTER TABLE gtfs.fare_attributes
  DROP CONSTRAINT gtfs.fare_attributes_pkey CASCADE;

DROP INDEX gtfs.shapes_shape_key;

ALTER TABLE gtfs.trips
  DROP CONSTRAINT gtfs.trips_pkey CASCADE;
DROP INDEX gtfs.trips_service_id;

ALTER TABLE gtfs.stop_times
  DROP CONSTRAINT gtfs.stop_times_pkey CASCADE;
DROP INDEX gtfs.stop_times_key;

DROP INDEX arr_time_index;
DROP INDEX dep_time_index;

ALTER TABLE gtfs.shape_geoms
  DROP CONSTRAINT gtfs.shape_geom_pkey CASCADE;

ALTER TABLE gtfs.frequencies
  DROP CONSTRAINT gtfs.frequencies_pkey CASCADE;
