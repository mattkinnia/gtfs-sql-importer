SET search_path to :schema, public;

ALTER TABLE stops
  DROP CONSTRAINT stops_level_id_fkey CASCADE;

ALTER TABLE :schema.routes
    DROP CONSTRAINT routes_agency_id_fkey CASCADE,
    DROP CONSTRAINT route_types_fkey CASCADE;

ALTER TABLE :schema.fare_attributes
    DROP CONSTRAINT fare_attributes_fkey CASCADE;

ALTER TABLE :schema.calendar_dates
    DROP CONSTRAINT calendar_dates_service_id_fkey CASCADE;

ALTER TABLE :schema.fare_rules
    DROP CONSTRAINT fare_rules_service_fkey CASCADE,
    DROP CONSTRAINT fare_rules_route_id_fkey CASCADE,
    DROP CONSTRAINT fare_rules_fare_id_fkey CASCADE;

ALTER TABLE :schema.trips
    DROP CONSTRAINT trips_route_id_fkey CASCADE,
    DROP CONSTRAINT trips_calendar_fkey CASCADE;

ALTER TABLE :schema.stop_times
    DROP CONSTRAINT stop_times_trips_fkey CASCADE,
    DROP CONSTRAINT stop_times_stops_fkey CASCADE;

ALTER TABLE :schema.frequencies
    DROP CONSTRAINT frequencies_trip_fkey CASCADE;

ALTER TABLE :schema.transfers
    DROP CONSTRAINT transfers_from_stop_fkey CASCADE,
    DROP CONSTRAINT transfers_to_stop_fkey CASCADE,
    DROP CONSTRAINT transfers_from_route_fkey CASCADE,
    DROP CONSTRAINT transfers_to_route_fkey CASCADE,
    DROP CONSTRAINT transfers_service_fkey CASCADE;

ALTER TABLE attributions
  DROP CONSTRAINT attributions_trip_id_fkey CASCADE,
  DROP CONSTRAINT attributions_route_id_fkey CASCADE;
