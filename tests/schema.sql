BEGIN;
SET search_path TO tap, public;

SELECT plan(116);

SELECT has_schema(:'schema');

SELECT functions_are(:'schema', ARRAY[
    'dist_insert',
    'dist_update',
    'feed_date_update',
    'safe_locate',
    'shape_update',
    'stop_geom_update'
]);

SELECT is(md5(p.prosrc), 'a87fda2155c046c96052c56d9be1b7ce', 'Function dist_insert body should match checksum')
  FROM pg_catalog.pg_proc p
  JOIN pg_catalog.pg_namespace n ON p.pronamespace = n.oid
 WHERE n.nspname = :'schema'
   AND proname = 'dist_insert'
   AND proargtypes::text = '';

SELECT is(md5(p.prosrc), 'a862974bb001b0e608d1a56110d30f03', 'Function dist_update body should match checksum')
  FROM pg_catalog.pg_proc p
  JOIN pg_catalog.pg_namespace n ON p.pronamespace = n.oid
 WHERE n.nspname = :'schema'
   AND proname = 'dist_update'
   AND proargtypes::text = '';

SELECT is(md5(p.prosrc), '2065575f11e67e941eda441c4994c629', 'Function safe_locate body should match checksum')
  FROM pg_catalog.pg_proc p
  JOIN pg_catalog.pg_namespace n ON p.pronamespace = n.oid
 WHERE n.nspname = :'schema'
   AND proname = 'safe_locate'
   AND proargtypes::text = '24724 24724 1700 1700 1700';

SELECT is(md5(p.prosrc), '616b269581704c146937a1b8abdcc1c7', 'Function shape_update body should match checksum')
  FROM pg_catalog.pg_proc p
  JOIN pg_catalog.pg_namespace n ON p.pronamespace = n.oid
 WHERE n.nspname = :'schema'
   AND proname = 'shape_update'
   AND proargtypes::text = '';

SELECT is(md5(p.prosrc), 'b1f84dc082d7ec534c8c90d5982a941c', 'Function stop_geom_update body should match checksum')
  FROM pg_catalog.pg_proc p
  JOIN pg_catalog.pg_namespace n ON p.pronamespace = n.oid
 WHERE n.nspname = :'schema'
   AND proname = 'stop_geom_update'
   AND proargtypes::text = '';

SELECT has_table(:'schema', 'continuous_pickup', 'Should have table gtfs.continuous_pickup');
SELECT has_pk(:'schema', 'continuous_pickup', 'Table gtfs.continuous_pickup should have a primary key');
SELECT columns_are(:'schema'::name, 'continuous_pickup'::name, ARRAY['continuous_pickup', 'description']::name[]);

SELECT has_column(       :'schema', 'continuous_pickup', 'continuous_pickup', 'Column gtfs.continuous_pickup.continuous_pickup should exist');
SELECT col_type_is(      :'schema', 'continuous_pickup', 'continuous_pickup', 'integer', 'Column gtfs.continuous_pickup.continuous_pickup should be type integer');
SELECT col_not_null(     :'schema', 'continuous_pickup', 'continuous_pickup', 'Column gtfs.continuous_pickup.continuous_pickup should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'continuous_pickup', 'continuous_pickup', 'Column gtfs.continuous_pickup.continuous_pickup should not  have a default');

SELECT has_column(       :'schema', 'continuous_pickup', 'description', 'Column gtfs.continuous_pickup.description should exist');
SELECT col_type_is(      :'schema', 'continuous_pickup', 'description', 'text', 'Column gtfs.continuous_pickup.description should be type text');
SELECT col_is_null(      :'schema', 'continuous_pickup', 'description', 'Column gtfs.continuous_pickup.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'continuous_pickup', 'description', 'Column gtfs.continuous_pickup.description should not  have a default');

SELECT has_table(:'schema', 'exception_types', 'Should have table gtfs.exception_types');
SELECT has_pk(:'schema', 'exception_types', 'Table gtfs.exception_types should have a primary key');
SELECT columns_are(:'schema'::name, 'exception_types'::name, ARRAY['exception_type', 'description']::name[]);

SELECT has_column(       :'schema', 'exception_types', 'exception_type', 'Column gtfs.exception_types.exception_type should exist');
SELECT col_type_is(      :'schema', 'exception_types', 'exception_type', 'integer', 'Column gtfs.exception_types.exception_type should be type integer');
SELECT col_not_null(     :'schema', 'exception_types', 'exception_type', 'Column gtfs.exception_types.exception_type should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'exception_types', 'exception_type', 'Column gtfs.exception_types.exception_type should not  have a default');

SELECT has_column(       :'schema', 'exception_types', 'description', 'Column gtfs.exception_types.description should exist');
SELECT col_type_is(      :'schema', 'exception_types', 'description', 'text', 'Column gtfs.exception_types.description should be type text');
SELECT col_is_null(      :'schema', 'exception_types', 'description', 'Column gtfs.exception_types.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'exception_types', 'description', 'Column gtfs.exception_types.description should not  have a default');

SELECT has_table(:'schema', 'location_types', 'Should have table gtfs.location_types');
SELECT has_pk(:'schema', 'location_types', 'Table gtfs.location_types should have a primary key');
SELECT columns_are(:'schema'::name, 'location_types'::name, ARRAY['location_type'::name, 'description'::name]);

SELECT has_column(       :'schema', 'location_types', 'location_type', 'Column gtfs.location_types.location_type should exist');
SELECT col_type_is(      :'schema', 'location_types', 'location_type', 'integer', 'Column gtfs.location_types.location_type should be type integer');
SELECT col_not_null(     :'schema', 'location_types', 'location_type', 'Column gtfs.location_types.location_type should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'location_types', 'location_type', 'Column gtfs.location_types.location_type should not  have a default');

SELECT has_column(       :'schema', 'location_types', 'description', 'Column gtfs.location_types.description should exist');
SELECT col_type_is(      :'schema', 'location_types', 'description', 'text', 'Column gtfs.location_types.description should be type text');
SELECT col_is_null(      :'schema', 'location_types', 'description', 'Column gtfs.location_types.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'location_types', 'description', 'Column gtfs.location_types.description should not  have a default');

SELECT has_table(:'schema', 'pathway_modes', 'Should have table gtfs.pathway_modes');
SELECT has_pk(:'schema', 'pathway_modes', 'Table gtfs.pathway_modes should have a primary key');
SELECT columns_are(:'schema'::name, 'pathway_modes'::name, ARRAY['pathway_mode'::name, 'description'::name]);

SELECT has_column(       :'schema', 'pathway_modes', 'pathway_mode', 'Column gtfs.pathway_modes.pathway_mode should exist');
SELECT col_type_is(      :'schema', 'pathway_modes', 'pathway_mode', 'integer', 'Column gtfs.pathway_modes.pathway_mode should be type integer');
SELECT col_not_null(     :'schema', 'pathway_modes', 'pathway_mode', 'Column gtfs.pathway_modes.pathway_mode should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'pathway_modes', 'pathway_mode', 'Column gtfs.pathway_modes.pathway_mode should not  have a default');

SELECT has_column(       :'schema', 'pathway_modes', 'description', 'Column gtfs.pathway_modes.description should exist');
SELECT col_type_is(      :'schema', 'pathway_modes', 'description', 'text', 'Column gtfs.pathway_modes.description should be type text');
SELECT col_is_null(      :'schema', 'pathway_modes', 'description', 'Column gtfs.pathway_modes.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathway_modes', 'description', 'Column gtfs.pathway_modes.description should not  have a default');

SELECT has_table(:'schema', 'payment_methods', 'Should have table gtfs.payment_methods');
SELECT has_pk(:'schema', 'payment_methods', 'Table gtfs.payment_methods should have a primary key');
SELECT columns_are(:'schema'::name, 'payment_methods'::name, ARRAY['payment_method'::name, 'description'::name]);

SELECT has_column(       :'schema', 'payment_methods', 'payment_method', 'Column gtfs.payment_methods.payment_method should exist');
SELECT col_type_is(      :'schema', 'payment_methods', 'payment_method', 'integer', 'Column gtfs.payment_methods.payment_method should be type integer');
SELECT col_not_null(     :'schema', 'payment_methods', 'payment_method', 'Column gtfs.payment_methods.payment_method should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'payment_methods', 'payment_method', 'Column gtfs.payment_methods.payment_method should not  have a default');

SELECT has_column(       :'schema', 'payment_methods', 'description', 'Column gtfs.payment_methods.description should exist');
SELECT col_type_is(      :'schema', 'payment_methods', 'description', 'text', 'Column gtfs.payment_methods.description should be type text');
SELECT col_is_null(      :'schema', 'payment_methods', 'description', 'Column gtfs.payment_methods.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'payment_methods', 'description', 'Column gtfs.payment_methods.description should not  have a default');

SELECT has_table(:'schema', 'pickup_dropoff_types', 'Should have table gtfs.pickup_dropoff_types');
SELECT has_pk(:'schema', 'pickup_dropoff_types', 'Table gtfs.pickup_dropoff_types should have a primary key');
SELECT columns_are(:'schema'::name, 'pickup_dropoff_types'::name, ARRAY['type_id'::name, 'description'::name]);

SELECT has_column(       :'schema', 'pickup_dropoff_types', 'type_id', 'Column gtfs.pickup_dropoff_types.type_id should exist');
SELECT col_type_is(      :'schema', 'pickup_dropoff_types', 'type_id', 'integer', 'Column gtfs.pickup_dropoff_types.type_id should be type integer');
SELECT col_not_null(     :'schema', 'pickup_dropoff_types', 'type_id', 'Column gtfs.pickup_dropoff_types.type_id should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'pickup_dropoff_types', 'type_id', 'Column gtfs.pickup_dropoff_types.type_id should not  have a default');

SELECT has_column(       :'schema', 'pickup_dropoff_types', 'description', 'Column gtfs.pickup_dropoff_types.description should exist');
SELECT col_type_is(      :'schema', 'pickup_dropoff_types', 'description', 'text', 'Column gtfs.pickup_dropoff_types.description should be type text');
SELECT col_is_null(      :'schema', 'pickup_dropoff_types', 'description', 'Column gtfs.pickup_dropoff_types.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'pickup_dropoff_types', 'description', 'Column gtfs.pickup_dropoff_types.description should not  have a default');

SELECT has_table(:'schema', 'route_types', 'Should have table gtfs.route_types');
SELECT has_pk(:'schema', 'route_types', 'Table gtfs.route_types should have a primary key');
SELECT columns_are(:'schema'::name, 'route_types'::name, ARRAY['route_type'::name,'description'::name]);

SELECT has_column(       :'schema', 'route_types', 'route_type', 'Column gtfs.route_types.route_type should exist');
SELECT col_type_is(      :'schema', 'route_types', 'route_type', 'integer', 'Column gtfs.route_types.route_type should be type integer');
SELECT col_not_null(     :'schema', 'route_types', 'route_type', 'Column gtfs.route_types.route_type should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'route_types', 'route_type', 'Column gtfs.route_types.route_type should not  have a default');

SELECT has_column(       :'schema', 'route_types', 'description', 'Column gtfs.route_types.description should exist');
SELECT col_type_is(      :'schema', 'route_types', 'description', 'text', 'Column gtfs.route_types.description should be type text');
SELECT col_is_null(      :'schema', 'route_types', 'description', 'Column gtfs.route_types.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'route_types', 'description', 'Column gtfs.route_types.description should not  have a default');

SELECT has_table(:'schema', 'transfer_types', 'Should have table gtfs.transfer_types');
SELECT has_pk(:'schema', 'transfer_types','Table gtfs.transfer_types should have a primary key');
SELECT columns_are(:'schema'::name, 'transfer_types'::name, ARRAY['transfer_type'::name,'description'::name]);

SELECT has_column(       :'schema', 'transfer_types', 'transfer_type', 'Column gtfs.transfer_types.transfer_type should exist');
SELECT col_type_is(      :'schema', 'transfer_types', 'transfer_type', 'integer', 'Column gtfs.transfer_types.transfer_type should be type integer');
SELECT col_not_null(     :'schema', 'transfer_types', 'transfer_type', 'Column gtfs.transfer_types.transfer_type should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'transfer_types', 'transfer_type', 'Column gtfs.transfer_types.transfer_type should not  have a default');

SELECT has_column(       :'schema', 'transfer_types', 'description', 'Column gtfs.transfer_types.description should exist');
SELECT col_type_is(      :'schema', 'transfer_types', 'description', 'text', 'Column gtfs.transfer_types.description should be type text');
SELECT col_is_null(      :'schema', 'transfer_types', 'description', 'Column gtfs.transfer_types.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'transfer_types', 'description', 'Column gtfs.transfer_types.description should not  have a default');

SELECT has_table(:'schema', 'wheelchair_accessible', 'Should have table gtfs.wheelchair_accessible');
SELECT has_pk(:'schema', 'wheelchair_accessible', 'Table gtfs.wheelchair_accessible should have a primary key');
SELECT columns_are(:'schema'::name, 'wheelchair_accessible'::name, ARRAY['wheelchair_accessible'::name, 'description'::name]);

SELECT has_column(       :'schema', 'wheelchair_accessible', 'wheelchair_accessible', 'Column gtfs.wheelchair_accessible.wheelchair_accessible should exist');
SELECT col_type_is(      :'schema', 'wheelchair_accessible', 'wheelchair_accessible', 'integer', 'Column gtfs.wheelchair_accessible.wheelchair_accessible should be type integer');
SELECT col_not_null(     :'schema', 'wheelchair_accessible', 'wheelchair_accessible', 'Column gtfs.wheelchair_accessible.wheelchair_accessible should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'wheelchair_accessible', 'wheelchair_accessible', 'Column gtfs.wheelchair_accessible.wheelchair_accessible should not  have a default');

SELECT has_column(       :'schema', 'wheelchair_accessible', 'description', 'Column gtfs.wheelchair_accessible.description should exist');
SELECT col_type_is(      :'schema', 'wheelchair_accessible', 'description', 'text', 'Column gtfs.wheelchair_accessible.description should be type text');
SELECT col_is_null(      :'schema', 'wheelchair_accessible', 'description', 'Column gtfs.wheelchair_accessible.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'wheelchair_accessible', 'description', 'Column gtfs.wheelchair_accessible.description should not  have a default');

SELECT has_table(:'schema', 'wheelchair_boardings', 'Should have table gtfs.wheelchair_boardings');
SELECT has_pk(:'schema', 'wheelchair_boardings', 'Table gtfs.wheelchair_boardings should have a primary key');
SELECT columns_are(:'schema'::name, 'wheelchair_boardings'::name, ARRAY['wheelchair_boarding'::name, 'description'::name]);

SELECT has_column(       :'schema', 'wheelchair_boardings', 'wheelchair_boarding', 'Column gtfs.wheelchair_boardings.wheelchair_boarding should exist');
SELECT col_type_is(      :'schema', 'wheelchair_boardings', 'wheelchair_boarding', 'integer', 'Column gtfs.wheelchair_boardings.wheelchair_boarding should be type integer');
SELECT col_not_null(     :'schema', 'wheelchair_boardings', 'wheelchair_boarding', 'Column gtfs.wheelchair_boardings.wheelchair_boarding should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'wheelchair_boardings', 'wheelchair_boarding', 'Column gtfs.wheelchair_boardings.wheelchair_boarding should not  have a default');

SELECT has_column(       :'schema', 'wheelchair_boardings', 'description', 'Column gtfs.wheelchair_boardings.description should exist');
SELECT col_type_is(      :'schema', 'wheelchair_boardings', 'description', 'text', 'Column gtfs.wheelchair_boardings.description should be type text');
SELECT col_is_null(      :'schema', 'wheelchair_boardings', 'description', 'Column gtfs.wheelchair_boardings.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'wheelchair_boardings', 'description', 'Column gtfs.wheelchair_boardings.description should not  have a default');

SELECT * FROM finish();
ROLLBACK;
