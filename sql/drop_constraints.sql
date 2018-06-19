-- gtfs.routes

ALTER TABLE gtfs.routes
    DROP CONSTRAINT gtfs_routes_fkey CASCADE;
ALTER TABLE gtfs.routes
    DROP CONSTRAINT gtfs_route_types_fkey CASCADE;

-- gtfs.fare_attributes

ALTER TABLE gtfs.fare_attributes
    DROP CONSTRAINT gtfs_fare_attributes_fkey CASCADE;

-- gtfs.calendar_dates

ALTER TABLE gtfs.calendar_dates
    DROP CONSTRAINT gtfs_calendar_fkey CASCADE;

-- gtfs.fare_rules

ALTER TABLE gtfs.fare_rules
    DROP CONSTRAINT gtfs_fare_rules_service_fkey CASCADE;
ALTER TABLE gtfs.fare_rules
    DROP CONSTRAINT gtfs_fare_rules_route_id_fkey CASCADE;
ALTER TABLE gtfs.fare_rules
    DROP CONSTRAINT gtfs_fare_rules_fare_id_fkey CASCADE;

-- gtfs.trips

ALTER TABLE gtfs.trips
    DROP CONSTRAINT gtfs_trips_route_id_fkey CASCADE;
ALTER TABLE gtfs.trips
    DROP CONSTRAINT gtfs_trips_calendar_fkey CASCADE;

-- gtfs.stop_times

ALTER TABLE gtfs.stop_times
    DROP CONSTRAINT gtfs_stop_times_trips_fkey CASCADE;
ALTER TABLE gtfs.stop_times
    DROP CONSTRAINT gtfs_stop_times_stops_fkey CASCADE;

-- gtfs.frequencies

ALTER TABLE gtfs.frequencies
    DROP CONSTRAINT gtfs_frequencies_trip_fkey CASCADE;

-- gtfs.transfers

ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs_transfers_from_stop_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs_transfers_to_stop_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs_transfers_from_route_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs_transfers_to_route_fkey CASCADE;
ALTER TABLE gtfs.transfers
    DROP CONSTRAINT gtfs_transfers_service_fkey CASCADE;
