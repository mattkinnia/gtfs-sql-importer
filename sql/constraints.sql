SET search_path to :schema, public;

ALTER TABLE stops
  ADD CONSTRAINT stops_level_id_fkey FOREIGN KEY (feed_index, level_id) REFERENCES levels (feed_index, level_id);

ALTER TABLE routes
  ADD CONSTRAINT route_types_fkey FOREIGN KEY (route_type) REFERENCES route_types (route_type),
  ADD CONSTRAINT routes_agency_id_fkey FOREIGN KEY (feed_index, agency_id) REFERENCES agency (feed_index, agency_id);

ALTER TABLE calendar_dates
  ADD CONSTRAINT calendar_dates_service_id_fkey FOREIGN KEY (feed_index, service_id) REFERENCES calendar (feed_index, service_id);

ALTER TABLE fare_attributes
  ADD CONSTRAINT fare_attributes_fkey FOREIGN KEY (feed_index, agency_id) REFERENCES agency (feed_index, agency_id);

ALTER TABLE fare_rules
  ADD CONSTRAINT fare_rules_service_fkey FOREIGN KEY (feed_index, service_id) REFERENCES calendar (feed_index, service_id),
  ADD CONSTRAINT fare_rules_fare_id_fkey FOREIGN KEY (feed_index, fare_id) REFERENCES fare_attributes (feed_index, fare_id),
  ADD CONSTRAINT fare_rules_route_id_fkey FOREIGN KEY (feed_index, route_id) REFERENCES routes (feed_index, route_id);

ALTER TABLE trips
  ADD CONSTRAINT trips_route_id_fkey FOREIGN KEY (feed_index, route_id) REFERENCES routes (feed_index, route_id),
  ADD CONSTRAINT trips_calendar_fkey FOREIGN KEY (feed_index, service_id) REFERENCES calendar (feed_index, service_id);

ALTER TABLE stop_times
  ADD CONSTRAINT stop_times_trips_fkey FOREIGN KEY (feed_index, trip_id) REFERENCES trips (feed_index, trip_id),
  ADD CONSTRAINT stop_times_stops_fkey FOREIGN KEY (feed_index, stop_id) REFERENCES stops (feed_index, stop_id);

ALTER TABLE frequencies
  ADD CONSTRAINT frequencies_trip_fkey FOREIGN KEY (feed_index, trip_id) REFERENCES trips (feed_index, trip_id);

ALTER TABLE transfers
  ADD CONSTRAINT transfers_from_stop_fkey FOREIGN KEY (feed_index, from_stop_id) REFERENCES stops (feed_index, stop_id),
  ADD CONSTRAINT transfers_to_stop_fkey FOREIGN KEY (feed_index, to_stop_id) REFERENCES stops (feed_index, stop_id),
  ADD CONSTRAINT transfers_from_route_fkey FOREIGN KEY (feed_index, from_route_id) REFERENCES routes (feed_index, route_id),
  ADD CONSTRAINT transfers_to_route_fkey FOREIGN KEY (feed_index, to_route_id) REFERENCES routes (feed_index, route_id),
  ADD CONSTRAINT transfers_service_fkey FOREIGN KEY (feed_index, service_id) REFERENCES calendar (feed_index, service_id);

ALTER TABLE attributions
  ADD CONSTRAINT attributions_trip_id_fkey FOREIGN KEY (feed_index, trip_id) REFERENCES trips (feed_index, trip_id),
  ADD CONSTRAINT attributions_route_id_fkey FOREIGN KEY (feed_index, route_id) REFERENCES routes (feed_index, route_id);
