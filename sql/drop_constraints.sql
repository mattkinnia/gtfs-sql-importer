-- gtfs_routes

ALTER TABLE gtfs_routes
    DROP CONSTRAINT gtfs_routes_fkey CASCADE,
    DROP CONSTRAINT gtfs_route_types_fkey CASCADE;

-- gtfs_fare_attributes

ALTER TABLE gtfs_fare_attributes
    DROP CONSTRAINT gtfs_fare_attributes_fkey CASCADE;

-- gtfs_calendar_dates

ALTER TABLE gtfs_calendar_dates
    DROP CONSTRAINT gtfs_calendar_fkey CASCADE;

-- gtfs_fare_rules

ALTER TABLE gtfs_fare_rules
    DROP CONSTRAINT gtfs_fare_rules_service_fkey CASCADE,
    DROP CONSTRAINT gtfs_fare_rules_route_id_fkey CASCADE,
    DROP CONSTRAINT gtfs_fare_rules_fare_id_fkey CASCADE;

-- gtfs_trips

ALTER TABLE gtfs_trips
    DROP CONSTRAINT gtfs_trips_route_id_fkey CASCADE,
    DROP CONSTRAINT gtfs_trips_calendar_fkey CASCADE;

-- gtfs_stop_times

ALTER TABLE gtfs_stop_times
    DROP CONSTRAINT gtfs_stop_times_trips_fkey CASCADE,
    DROP CONSTRAINT gtfs_stop_times_stops_fkey CASCADE;

-- gtfs_frequencies

ALTER TABLE gtfs_frequencies
    DROP CONSTRAINT gtfs_frequencies_trip_fkey CASCADE;

-- gtfs_service_combinations

ALTER TABLE gtfs_service_combinations
  DROP CONSTRAINT service_combinations_service_fkey;

-- gtfs_transfers

ALTER TABLE gtfs_transfers
    DROP CONSTRAINT gtfs_transfers_from_stop_fkey CASCADE,
    DROP CONSTRAINT gtfs_transfers_to_stop_fkey CASCADE,
    DROP CONSTRAINT gtfs_transfers_from_route_fkey CASCADE,
    DROP CONSTRAINT gtfs_transfers_to_route_fkey CASCADE,
    DROP CONSTRAINT gtfs_transfers_service_fkey CASCADE;
