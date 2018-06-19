-- gtfs.routes

ALTER TABLE gtfs.routes
  ADD CONSTRAINT gtfs_route_types_fkey
  FOREIGN KEY (route_type)
  REFERENCES gtfs.route_types (route_type);

ALTER TABLE gtfs.routes
  ADD CONSTRAINT gtfs_routes_fkey
  FOREIGN KEY (feed_index, agency_id)
  REFERENCES gtfs.agency (feed_index, agency_id);

-- gtfs.calendar_dates

ALTER TABLE gtfs.calendar_dates
  ADD CONSTRAINT gtfs_calendar_fkey
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs.calendar (feed_index, service_id);

ALTER TABLE gtfs.fare_attributes
  ADD CONSTRAINT gtfs_fare_attributes_fkey
  FOREIGN KEY (feed_index, agency_id)
  REFERENCES gtfs.agency (feed_index, agency_id);

-- gtfs.fare_rules

ALTER TABLE gtfs.fare_rules
  ADD CONSTRAINT gtfs_fare_rules_service_fkey 
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs.calendar (feed_index, service_id);

ALTER TABLE gtfs.fare_rules
  ADD CONSTRAINT gtfs_fare_rules_fare_id_fkey
  FOREIGN KEY (feed_index, fare_id)
  REFERENCES gtfs.fare_attributes (feed_index, fare_id);

ALTER TABLE gtfs.fare_rules
  ADD CONSTRAINT gtfs_fare_rules_route_id_fkey
  FOREIGN KEY (feed_index, route_id)
  REFERENCES gtfs.routes (feed_index, route_id);

-- gtfs.trips

ALTER TABLE gtfs.trips
  ADD CONSTRAINT gtfs_trips_route_id_fkey
  FOREIGN KEY (feed_index, route_id)
  REFERENCES gtfs.routes (feed_index, route_id);

ALTER TABLE gtfs.trips
  ADD CONSTRAINT gtfs_trips_calendar_fkey
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs.calendar (feed_index, service_id);

-- gtfs.stop_times

ALTER TABLE gtfs.stop_times
  ADD CONSTRAINT gtfs_stop_times_trips_fkey
  FOREIGN KEY (feed_index, trip_id)
  REFERENCES gtfs.trips (feed_index, trip_id);

ALTER TABLE gtfs.stop_times
  ADD CONSTRAINT gtfs_stop_times_stops_fkey
  FOREIGN KEY (feed_index, stop_id)
  REFERENCES gtfs.stops (feed_index, stop_id);

-- gtfs.frequencies

ALTER TABLE gtfs.frequencies
  ADD CONSTRAINT gtfs_frequencies_trip_fkey
  FOREIGN KEY (feed_index, trip_id)
  REFERENCES gtfs.trips (feed_index, trip_id);

-- gtfs.transfers

ALTER TABLE gtfs.transfers
  ADD CONSTRAINT gtfs_transfers_from_stop_fkey
  FOREIGN KEY (feed_index, from_stop_id)
  REFERENCES gtfs.stops (feed_index, stop_id);

ALTER TABLE gtfs.transfers
  ADD CONSTRAINT gtfs_transfers_to_stop_fkey
  FOREIGN KEY (feed_index, to_stop_id)
  REFERENCES gtfs.stops (feed_index, stop_id);

ALTER TABLE gtfs.transfers
  ADD CONSTRAINT gtfs_transfers_from_route_fkey
  FOREIGN KEY (feed_index, from_route_id)
  REFERENCES gtfs.routes (feed_index, route_id);

ALTER TABLE gtfs.transfers
  ADD CONSTRAINT gtfs_transfers_to_route_fkey
  FOREIGN KEY (feed_index, to_route_id)
  REFERENCES gtfs.routes (feed_index, route_id);

ALTER TABLE gtfs.transfers
  ADD CONSTRAINT gtfs_transfers_service_fkey
  FOREIGN KEY (feed_index, service_id)
  REFERENCES gtfs.calendar (feed_index, service_id);
