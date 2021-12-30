BEGIN;
SET search_path to tap, public;

SELECT plan(28);

SELECT col_is_fk(:'schema', 'routes', ARRAY['route_type'], 'routes.route_type is a foreign key');
SELECT col_is_fk(:'schema', 'routes', ARRAY['feed_index', 'agency_id'], 'routes.agency_id is a foreign key');
SELECT col_is_fk(:'schema', 'routes', ARRAY['continuous_pickup'], 'routes.continuous_pickup is a foreign key');
SELECT col_is_fk(:'schema', 'routes', ARRAY['continuous_drop_off'], 'routes.continuous_drop_off is a foreign key');

SELECT col_is_fk(:'schema', 'calendar_dates', ARRAY['feed_index', 'service_id'], 'calendar_dates.service_id is a foreign key');
SELECT col_is_fk(:'schema', 'calendar_dates', ARRAY['exception_type'], 'calendar_dates.exception_type is a foreign key');

SELECT col_is_fk(:'schema', 'fare_attributes', ARRAY['feed_index', 'agency_id'], 'fare_attributes.agency_id is a foreign key');
SELECT col_is_fk(:'schema', 'fare_attributes', ARRAY['payment_method'], 'fare_attributes.payment_method is a foreign key');

SELECT col_is_fk(:'schema', 'fare_rules', ARRAY['feed_index', 'service_id'], 'fare_rules.service_id is a foreign key');
SELECT col_is_fk(:'schema', 'fare_rules', ARRAY['feed_index', 'fare_id'], 'fare_rules.fare_id is a foreign key');
SELECT col_is_fk(:'schema', 'fare_rules', ARRAY['feed_index', 'route_id'], 'fare_rules.route_id is a foreign key');

SELECT col_is_fk(:'schema', 'trips', ARRAY['feed_index', 'route_id'], 'trips.route_id is a foreign key');
SELECT col_is_fk(:'schema', 'trips', ARRAY['feed_index', 'service_id'], 'trips.service_id is a foreign key');
SELECT col_is_fk(:'schema', 'trips', ARRAY['wheelchair_accessible'], 'trips.wheelchair_accessible is a foreign key');

SELECT col_is_fk(:'schema', 'stop_times', ARRAY['feed_index', 'trip_id'], 'stop_times.trip_id is a foreign key');
SELECT col_is_fk(:'schema', 'stop_times', ARRAY['feed_index', 'stop_id'], 'stop_times.stop_id is a foreign key');
SELECT col_is_fk(:'schema', 'stop_times', ARRAY['continuous_pickup'], 'stop_times.continuous_pickup is a foreign key');
SELECT col_is_fk(:'schema', 'stop_times', ARRAY['pickup_type'], 'stop_times.pickup_type is a foreign key');
SELECT col_is_fk(:'schema', 'stop_times', ARRAY['drop_off_type'], 'stop_times.drop_off_type is a foreign key');
SELECT col_is_fk(:'schema', 'stop_times', ARRAY['continuous_pickup'], 'stop_times.continuous_pickup is a foreign key');
SELECT col_is_fk(:'schema', 'stop_times', ARRAY['continuous_drop_off'], 'stop_times.continuous_drop_off is a foreign key');

SELECT col_is_fk(:'schema', 'frequencies', ARRAY['feed_index', 'trip_id'], 'frequencies.trip_id is a foreign key');

SELECT col_is_fk(:'schema', 'transfers', ARRAY['feed_index', 'from_stop_id'], 'transfers.from_stop_id is a foreign key');
SELECT col_is_fk(:'schema', 'transfers', ARRAY['feed_index', 'to_stop_id'], 'transfers.to_stop_id is a foreign key');
SELECT col_is_fk(:'schema', 'transfers', ARRAY['feed_index', 'from_route_id'], 'transfers.from_route_id is a foreign key');
SELECT col_is_fk(:'schema', 'transfers', ARRAY['feed_index', 'to_route_id'], 'transfers.to_route_id is a foreign key');
SELECT col_is_fk(:'schema', 'transfers', ARRAY['feed_index', 'service_id'], 'transfers.service_id is a foreign key');

SELECT col_is_fk(:'schema', 'stops', ARRAY['feed_index','level_id'], 'stops.level_id is a foreign key');

SELECT col_is_fk(:'schema', 'attributions', ARRAY['feed_index','trip_id'], 'attributions.trip_id is a foreign key');
SELECT col_is_fk(:'schema', 'attributions', ARRAY['feed_index','route_id'], 'attributions.route_id is a foreign key');

SELECT * FROM finish();
ROLLBACK;
