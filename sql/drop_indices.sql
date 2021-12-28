SET search_path to :schema, public;

ALTER TABLE agency
  DROP CONSTRAINT agency_pkey CASCADE;

ALTER TABLE calendar
  DROP CONSTRAINT calendar_pkey CASCADE;
DROP INDEX calendar_service_id;

ALTER TABLE stops
  DROP CONSTRAINT stops_pkey CASCADE;

DROP INDEX stops_geom_idx;

ALTER TABLE routes
  DROP CONSTRAINT routes_pkey CASCADE;

DROP INDEX calendar_dates_dateidx;

ALTER TABLE fare_attributes
  DROP CONSTRAINT fare_attributes_pkey CASCADE;

DROP INDEX shapes_shape_key;

ALTER TABLE trips
  DROP CONSTRAINT trips_pkey CASCADE;
DROP INDEX trips_service_id;

ALTER TABLE stop_times
  DROP CONSTRAINT stop_times_pkey CASCADE;

DROP INDEX stop_times_key;
DROP INDEX arr_time_index;
DROP INDEX dep_time_index;

ALTER TABLE shape_geoms
  DROP CONSTRAINT shape_geom_pkey CASCADE;

DROP INDEX shape_geoms_geom_idx;

ALTER TABLE frequencies
  DROP CONSTRAINT frequencies_pkey CASCADE;
