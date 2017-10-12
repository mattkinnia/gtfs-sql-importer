BEGIN;

ALTER TABLE gtfs_agency
  ADD CONSTRAINT gtfs_agency_pkey
  PRIMARY KEY (feed_index, agency_id);

ALTER TABLE gtfs_calendar
  ADD CONSTRAINT gtfs_calendar_pkey
  PRIMARY KEY (feed_index, service_id);

CREATE INDEX gtfs_calendar_service_id ON gtfs_calendar (feed_index, service_id);

ALTER TABLE gtfs_stops
  ADD CONSTRAINT gtfs_stops_pkey
  PRIMARY KEY (feed_index, stop_id);

ALTER TABLE gtfs_routes
  ADD CONSTRAINT gtfs_routes_pkey
  PRIMARY KEY (feed_index, route_id);

CREATE INDEX gtfs_calendar_dates_dateidx ON gtfs_calendar_dates (date);

ALTER TABLE gtfs_fare_attributes
  ADD CONSTRAINT gtfs_fare_attributes_pkey
  PRIMARY KEY (feed_index, fare_id);

CREATE INDEX gtfs_shapes_shape_key ON gtfs_shapes (shape_id);

ALTER TABLE gtfs_trips
  ADD CONSTRAINT gtfs_trips_pkey
  PRIMARY KEY (feed_index, trip_id);

CREATE INDEX gtfs_trips_service_id ON gtfs_trips (feed_index, service_id);

ALTER TABLE gtfs_stop_times
  ADD CONSTRAINT gtfs_stop_times_pkey
  PRIMARY KEY (feed_index, trip_id, stop_sequence);

CREATE INDEX gtfs_stop_times_key ON gtfs_stop_times (feed_index, trip_id, stop_id);
CREATE INDEX arr_time_index ON gtfs_stop_times (arrival_time_seconds);
CREATE INDEX dep_time_index ON gtfs_stop_times (departure_time_seconds);

ALTER TABLE gtfs_shape_geoms
  ADD CONSTRAINT gtfs_shape_geom_pkey
  PRIMARY KEY (feed_index, shape_id);

ALTER TABLE gtfs_frequencies
  ADD CONSTRAINT gtfs_frequencies_pkey
  PRIMARY KEY (feed_index, trip_id, start_time);

COMMIT;
