BEGIN;
SET search_path TO tap, public;

SELECT plan(114);

SELECT has_schema(:'schema');

SELECT functions_are(:'schema', ARRAY[
    'feed_date_update',
    'safe_locate',
    'stop_geom_update'
]);

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

SELECT is(md5(p.prosrc), '4b98b092dbb9f88986747b5c155dc39d', 'Function feed_date_update body should match checksum')
  FROM pg_catalog.pg_proc p
  JOIN pg_catalog.pg_namespace n ON p.pronamespace = n.oid
 WHERE n.nspname = :'schema'
   AND proname = 'feed_date_update'
   AND proargtypes::text = '';

SELECT has_trigger(:'schema'::name, 'calendar'::name, 'calendar_trigger'::name);
SELECT has_trigger(:'schema'::name, 'stops'::name, 'stop_geom_trigger'::name);

SELECT
  collect_tap(
    has_table(:'schema'::name, tname::name),
    has_pk(:'schema', tname, format('Table %s should have a primary key', tname)),
    columns_are(:'schema'::name, tname, cols),

    col_type_is(:'schema', tname, cols[1], 'integer', format('Column %s.%s should be type integer', tname, cols[1])),
    col_not_null(:'schema', tname, cols[1], format('Column %s.%s should be NOT NULL', tname, cols[1])),
    col_hasnt_default(:'schema', tname, cols[1], format('Column %s.%s should not have a default', tname, cols[1])),

    col_type_is(:'schema', tname, cols[2], 'text', format('Column %s.%s should be type text', tname, cols[2])),
    col_is_null(:'schema', tname, cols[2], format('Column %s.%s should be NOT NULL', tname, cols[2])),
    col_hasnt_default(:'schema', tname, cols[2], format('Column %s.%s should not have a default', tname, cols[2]))
  )
FROM (VALUES
  ('continuous_pickup'::name, ARRAY['continuous_pickup', 'description']::name[]),
  ('continuous_drop_off'::name, ARRAY['continuous_drop_off', 'description']::name[]),
  ('exception_types', ARRAY['exception_type', 'description']),
  ('location_types', ARRAY['location_type', 'description']),
  ('pathway_modes', ARRAY['pathway_mode', 'description']),
  ('payment_methods', ARRAY['payment_method', 'description']),
  ('pickup_dropoff_types', ARRAY['type_id', 'description']),
  ('route_types', ARRAY['route_type','description']),
  ('transfer_types', ARRAY['transfer_type','description']),
  ('wheelchair_accessible', ARRAY['wheelchair_accessible', 'description']),
  ('wheelchair_boardings', ARRAY['wheelchair_boarding', 'description']),
  ('timepoints', ARRAY['timepoint', 'description'])
) a (tname, cols);

SELECT * FROM finish();
ROLLBACK;
