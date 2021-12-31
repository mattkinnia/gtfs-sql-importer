BEGIN;
SET search_path TO tap, public;
SELECT plan(51);

SELECT has_table(
    :'schema', 'attributions',
    'Should have table gtfs.attributions'
);

SELECT has_pk(
    :'schema', 'attributions',
    'Table gtfs.attributions should have a primary key'
);

SELECT columns_are(:'schema'::name, 'attributions'::name, ARRAY[
    'feed_index'::name,
    'attribution_id'::name,
    'agency_id'::name,
    'route_id'::name,
    'trip_id'::name,
    'organization_name'::name,
    'is_producer'::name,
    'is_operator'::name,
    'is_authority'::name,
    'attribution_url'::name,
    'attribution_email'::name,
    'attribution_phone'::name
]);

SELECT has_column(       :'schema', 'attributions', 'feed_index', 'Column gtfs.attributions.feed_index should exist');
SELECT col_type_is(      :'schema', 'attributions', 'feed_index', 'integer', 'Column gtfs.attributions.feed_index should be type integer');
SELECT col_not_null(     :'schema', 'attributions', 'feed_index', 'Column gtfs.attributions.feed_index should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'feed_index', 'Column gtfs.attributions.feed_index should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'attribution_id', 'Column gtfs.attributions.attribution_id should exist');
SELECT col_type_is(      :'schema', 'attributions', 'attribution_id', 'text', 'Column gtfs.attributions.attribution_id should be type text');
SELECT col_not_null(     :'schema', 'attributions', 'attribution_id', 'Column gtfs.attributions.attribution_id should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'attribution_id', 'Column gtfs.attributions.attribution_id should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'agency_id', 'Column gtfs.attributions.agency_id should exist');
SELECT col_type_is(      :'schema', 'attributions', 'agency_id', 'text', 'Column gtfs.attributions.agency_id should be type text');
SELECT col_is_null(      :'schema', 'attributions', 'agency_id', 'Column gtfs.attributions.agency_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'agency_id', 'Column gtfs.attributions.agency_id should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'route_id', 'Column gtfs.attributions.route_id should exist');
SELECT col_type_is(      :'schema', 'attributions', 'route_id', 'text', 'Column gtfs.attributions.route_id should be type text');
SELECT col_is_null(      :'schema', 'attributions', 'route_id', 'Column gtfs.attributions.route_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'route_id', 'Column gtfs.attributions.route_id should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'trip_id', 'Column gtfs.attributions.trip_id should exist');
SELECT col_type_is(      :'schema', 'attributions', 'trip_id', 'text', 'Column gtfs.attributions.trip_id should be type text');
SELECT col_is_null(      :'schema', 'attributions', 'trip_id', 'Column gtfs.attributions.trip_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'trip_id', 'Column gtfs.attributions.trip_id should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'organization_name', 'Column gtfs.attributions.organization_name should exist');
SELECT col_type_is(      :'schema', 'attributions', 'organization_name', 'text', 'Column gtfs.attributions.organization_name should be type text');
SELECT col_not_null(     :'schema', 'attributions', 'organization_name', 'Column gtfs.attributions.organization_name should not allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'organization_name', 'Column gtfs.attributions.organization_name should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'is_producer', 'Column gtfs.attributions.is_producer should exist');
SELECT col_type_is(      :'schema', 'attributions', 'is_producer', 'boolean', 'Column gtfs.attributions.is_producer should be type boolean');
SELECT col_is_null(      :'schema', 'attributions', 'is_producer', 'Column gtfs.attributions.is_producer should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'is_producer', 'Column gtfs.attributions.is_producer should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'is_operator', 'Column gtfs.attributions.is_operator should exist');
SELECT col_type_is(      :'schema', 'attributions', 'is_operator', 'boolean', 'Column gtfs.attributions.is_operator should be type boolean');
SELECT col_is_null(      :'schema', 'attributions', 'is_operator', 'Column gtfs.attributions.is_operator should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'is_operator', 'Column gtfs.attributions.is_operator should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'is_authority', 'Column gtfs.attributions.is_authority should exist');
SELECT col_type_is(      :'schema', 'attributions', 'is_authority', 'boolean', 'Column gtfs.attributions.is_authority should be type boolean');
SELECT col_is_null(      :'schema', 'attributions', 'is_authority', 'Column gtfs.attributions.is_authority should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'is_authority', 'Column gtfs.attributions.is_authority should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'attribution_url', 'Column gtfs.attributions.attribution_url should exist');
SELECT col_type_is(      :'schema', 'attributions', 'attribution_url', 'text', 'Column gtfs.attributions.attribution_url should be type text');
SELECT col_is_null(      :'schema', 'attributions', 'attribution_url', 'Column gtfs.attributions.attribution_url should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'attribution_url', 'Column gtfs.attributions.attribution_url should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'attribution_email', 'Column gtfs.attributions.attribution_email should exist');
SELECT col_type_is(      :'schema', 'attributions', 'attribution_email', 'text', 'Column gtfs.attributions.attribution_email should be type text');
SELECT col_is_null(      :'schema', 'attributions', 'attribution_email', 'Column gtfs.attributions.attribution_email should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'attribution_email', 'Column gtfs.attributions.attribution_email should not  have a default');

SELECT has_column(       :'schema', 'attributions', 'attribution_phone', 'Column gtfs.attributions.attribution_phone should exist');
SELECT col_type_is(      :'schema', 'attributions', 'attribution_phone', 'text', 'Column gtfs.attributions.attribution_phone should be type text');
SELECT col_is_null(      :'schema', 'attributions', 'attribution_phone', 'Column gtfs.attributions.attribution_phone should allow NULL');
SELECT col_hasnt_default(:'schema', 'attributions', 'attribution_phone', 'Column gtfs.attributions.attribution_phone should not  have a default');

SELECT * FROM finish();
ROLLBACK;
