BEGIN;

-- commented-out constraints are removed by CASCADE

ALTER TABLE gtfs_routes DROP CONSTRAINT gtfs_routes_fkey CASCADE;
ALTER TABLE gtfs_calendar_dates DROP CONSTRAINT gtfs_calendar_fkey CASCADE;

ALTER TABLE gtfs_routes
    DROP CONSTRAINT gtfs_route_types_fkey CASCADE;

ALTER TABLE gtfs_fare_attributes
    -- DROP CONSTRAINT gtfs_fare_attributes_fkey CASCADE
    DROP CONSTRAINT gtfs_fare_attributes_pkey CASCADE;

/*
ALTER TABLE gtfs_fare_rules
    DROP CONSTRAINT gtfs_fare_rules_service_fkey CASCADE
    DROP CONSTRAINT gtfs_fare_rules_fare_id_fkey CASCADE
    DROP CONSTRAINT gtfs_fare_rules_route_id_fkey CASCADE;
*/

ALTER TABLE gtfs_trips
    -- DROP CONSTRAINT gtfs_trips_route_id_fkey CASCADE
    -- DROP CONSTRAINT gtfs_trips_calendar_fkey CASCADE
    DROP CONSTRAINT gtfs_trips_pkey CASCADE;

ALTER TABLE gtfs_stop_times
    -- DROP CONSTRAINT gtfs_stop_times_trips_fkey CASCADE
    -- DROP CONSTRAINT gtfs_stop_times_stops_fkey CASCADE
    DROP CONSTRAINT gtfs_stop_times_pkey CASCADE;


ALTER TABLE gtfs_frequencies
    -- DROP CONSTRAINT gtfs_frequencies_trip_fkey CASCADE
    DROP CONSTRAINT gtfs_frequencies_pkey CASCADE;

/*
ALTER TABLE gtfs_transfers
    DROP CONSTRAINT gtfs_transfers_from_stop_fkey CASCADE
    DROP CONSTRAINT gtfs_transfers_to_stop_fkey CASCADE
    DROP CONSTRAINT gtfs_transfers_from_route_fkey CASCADE
    DROP CONSTRAINT gtfs_transfers_to_route_fkey CASCADE
    DROP CONSTRAINT gtfs_transfers_service_fkey CASCADE;
*/
COMMIT;
