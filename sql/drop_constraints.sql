-- gtfs.routes

ALTER TABLE gtfs.routes
    DROP CONSTRAINT gtfs.routes_fkey CASCADE;
ALTER TABLE gtfs.routes
    DROP CONSTRAINT gtfs.route_types_fkey CASCADE;

-- gtfs.fare_attributes

ALTER TABLE gtfs.fare_attributes
    DROP CONSTRAINT gtfs.fare_attributes_fkey CASCADE;

-- gtfs.calendar_dates

ALTER TABLE gtfs.calendar_dates
    DROP CONSTRAINT gtfs.calendar_fkey CASCADE;

-- gtfs.fare_rules

ALTER TABLE gtfs.fare_rules
    DROP CONSTRAINT gtfs.fare_rules_service_fkey CASCADE;
ALTER TABLE gtfs.fare_rules
    DROP CONSTRAINT gtfs.fare_rules_route_id_fkey CASCADE;
ALTER TABLE gtfs.fare_rules
    DROP CONSTRAINT gtfs.fare_rules_fare_id_fkey CASCADE;

-- gtfs.trips

ALTER TABLE gtfs.trips
    DROP CONSTRAINT gtfs.trips_route_id_fkey CASCADE;
ALTER TABLE gtfs.trips
    DROP CONSTRAINT gtfs.trips_calendar_fkey CASCADE;

-- gtfs.stop_times

ALTER TABLE gtfs.stop_times
    DROP CONSTRAINT gtfs.stop_times_trips_fkey CASCADE;
ALTER TABLE gtfs.stop_times
    DROP CONSTRAINT gtfs.stop_times_stops_fkey CASCADE;

-- gtfs.frequencies

ALTER TABLE gtfs.frequencies
    DROP CONSTRAINT gtfs.frequencies_trip_fkey CASCADE;

-- gtfs.transfers

ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs.transfers_from_stop_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs.transfers_to_stop_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs.transfers_from_route_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs.transfers_to_route_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs.transfers_service_fkey CASCADE;
