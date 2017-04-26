BEGIN;

ALTER TABLE gtfs_agency
  ADD CONSTRAINT gtfs_agency_pkey
  PRIMARY KEY (feed_index, agency_id);

ALTER TABLE gtfs_calendar
  ADD CONSTRAINT gtfs_calendar_pkey
  PRIMARY KEY (feed_index, service_id);

ALTER TABLE gtfs_stops
  ADD CONSTRAINT gtfs_stops_pkey
  PRIMARY KEY (feed_index, stop_id);

ALTER TABLE gtfs_routes
  ADD CONSTRAINT gtfs_route_types_fkey
  FOREIGN KEY (route_type)
  REFERENCES gtfs_route_types (route_type);
ALTER TABLE gtfs_routes
  ADD CONSTRAINT gtfs_routes_pkey
  PRIMARY KEY (feed_index, route_id);
ALTER TABLE gtfs_routes
  ADD CONSTRAINT gtfs_routes_fkey
  FOREIGN KEY (feed_index, agency_id)
  REFERENCES gtfs_agency (feed_index, agency_id);

ALTER TABLE gtfs_calendar_dates
  ADD CONSTRAINT gtfs_calendar_fkey
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs_calendar (feed_index, service_id);

CREATE INDEX gtfs_calendar_dates_dateidx ON gtfs_calendar_dates (date);

ALTER TABLE gtfs_fare_attributes
  ADD CONSTRAINT gtfs_fare_attributes_pkey
  PRIMARY KEY (feed_index, fare_id);
ALTER TABLE gtfs_fare_attributes
  ADD CONSTRAINT gtfs_fare_attributes_fkey
  FOREIGN KEY (feed_index, agency_id)
  REFERENCES gtfs_agency (feed_index, agency_id);

ALTER TABLE gtfs_fare_rules
  ADD CONSTRAINT gtfs_fare_rules_service_fkey 
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs_calendar (feed_index, service_id);
ALTER TABLE gtfs_fare_rules
  ADD CONSTRAINT gtfs_fare_rules_fare_id_fkey
  FOREIGN KEY (feed_index, fare_id)
  REFERENCES gtfs_fare_attributes (feed_index, fare_id);
ALTER TABLE gtfs_fare_rules
  ADD CONSTRAINT gtfs_fare_rules_route_id_fkey
  FOREIGN KEY (feed_index, route_id)
  REFERENCES gtfs_routes (feed_index, route_id);

CREATE INDEX gtfs_shapes_shape_key ON gtfs_shapes (shape_id);

ALTER TABLE gtfs_trips
  ADD CONSTRAINT gtfs_trips_pkey
  PRIMARY KEY (feed_index, trip_id);
ALTER TABLE gtfs_trips
  ADD CONSTRAINT gtfs_trips_route_id_fkey
  FOREIGN KEY (feed_index, route_id)
  REFERENCES gtfs_routes (feed_index, route_id);
ALTER TABLE gtfs_trips
  ADD CONSTRAINT gtfs_trips_calendar_fkey
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs_calendar (feed_index, service_id);

ALTER TABLE gtfs_stop_times
  ADD CONSTRAINT gtfs_stop_times_pkey
  PRIMARY KEY (feed_index, trip_id, stop_sequence);
ALTER TABLE gtfs_stop_times
  ADD CONSTRAINT gtfs_stop_times_trips_fkey
  FOREIGN KEY (feed_index, trip_id)
  REFERENCES gtfs_trips (feed_index, trip_id);
ALTER TABLE gtfs_stop_times
  ADD CONSTRAINT gtfs_stop_times_stops_fkey
  FOREIGN KEY (feed_index, stop_id)
  REFERENCES gtfs_stops (feed_index, stop_id);

CREATE INDEX gtfs_stop_times_key ON gtfs_stop_times (trip_id, stop_id);
CREATE INDEX arr_time_index ON gtfs_stop_times (arrival_time_seconds);
CREATE INDEX dep_time_index ON gtfs_stop_times (departure_time_seconds);

CREATE INDEX gtfs_stop_dist_along_shape_index ON gtfs_stop_distances_along_shape (feed_index, shape_id);

ALTER TABLE gtfs_shape_geoms
  ADD CONSTRAINT gtfs_shape_geom_pkey
  PRIMARY KEY (feed_index, shape_id);

ALTER TABLE gtfs_frequencies
  ADD CONSTRAINT gtfs_frequencies_pkey
  PRIMARY KEY (feed_index, trip_id, start_time);
ALTER TABLE gtfs_frequencies
  ADD CONSTRAINT gtfs_frequencies_trip_fkey
  FOREIGN KEY (feed_index, trip_id)
  REFERENCES gtfs_trips (feed_index, trip_id);

ALTER TABLE gtfs_transfers
  ADD CONSTRAINT gtfs_transfers_from_stop_fkey
  FOREIGN KEY (feed_index, from_stop_id)
  REFERENCES gtfs_stops (feed_index, stop_id);
ALTER TABLE gtfs_transfers
  ADD CONSTRAINT gtfs_transfers_to_stop_fkey
  FOREIGN KEY (feed_index, to_stop_id)
  REFERENCES gtfs_stops (feed_index, stop_id);
ALTER TABLE gtfs_transfers
  ADD CONSTRAINT gtfs_transfers_from_route_fkey
  FOREIGN KEY (feed_index, from_route_id)
  REFERENCES gtfs_routes (feed_index, route_id);
ALTER TABLE gtfs_transfers
  ADD CONSTRAINT gtfs_transfers_to_route_fkey
  FOREIGN KEY (feed_index, to_route_id)
  REFERENCES gtfs_routes (feed_index, route_id);
ALTER TABLE gtfs_transfers
  ADD CONSTRAINT gtfs_transfers_service_fkey
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs_calendar (feed_index, service_id);

COMMIT;
