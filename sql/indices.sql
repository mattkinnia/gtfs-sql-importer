BEGIN;

ALTER TABLE gtfs.agency
  ADD CONSTRAINT gtfs.agency_pkey
  PRIMARY KEY (feed_index, agency_id);

ALTER TABLE gtfs.calendar
  ADD CONSTRAINT gtfs.calendar_pkey
  PRIMARY KEY (feed_index, service_id);

CREATE INDEX gtfs.calendar_service_id ON gtfs.calendar (feed_index, service_id);

ALTER TABLE gtfs.stops
  ADD CONSTRAINT gtfs.stops_pkey
  PRIMARY KEY (feed_index, stop_id);

ALTER TABLE gtfs.routes
  ADD CONSTRAINT gtfs.routes_pkey
  PRIMARY KEY (feed_index, route_id);

CREATE INDEX gtfs.calendar_dates_dateidx ON gtfs.calendar_dates (date);

ALTER TABLE gtfs.fare_attributes
  ADD CONSTRAINT gtfs.fare_attributes_pkey
  PRIMARY KEY (feed_index, fare_id);

CREATE INDEX gtfs.shapes_shape_key ON gtfs.shapes (shape_id);

ALTER TABLE gtfs.trips
  ADD CONSTRAINT gtfs.trips_pkey
  PRIMARY KEY (feed_index, trip_id);

CREATE INDEX gtfs.trips_service_id ON gtfs.trips (feed_index, service_id);

ALTER TABLE gtfs.stop_times
  ADD CONSTRAINT gtfs.stop_times_pkey
  PRIMARY KEY (feed_index, trip_id, stop_sequence);

CREATE INDEX gtfs.stop_times_key ON gtfs.stop_times (feed_index, trip_id, stop_id);
CREATE INDEX arr_time_index ON gtfs.stop_times (arrival_time_seconds);
CREATE INDEX dep_time_index ON gtfs.stop_times (departure_time_seconds);

ALTER TABLE gtfs.shape_geoms
  ADD CONSTRAINT gtfs.shape_geom_pkey
  PRIMARY KEY (feed_index, shape_id);

ALTER TABLE gtfs.frequencies
  ADD CONSTRAINT gtfs.frequencies_pkey
  PRIMARY KEY (feed_index, trip_id, start_time);

COMMIT;
