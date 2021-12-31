BEGIN;
SET search_path TO tap, public;
SELECT plan(19);

SELECT has_table(:'schema', 'levels', 'Should have table gtfs.levels');

SELECT has_pk(
    :'schema', 'levels',
    'Table gtfs.levels should have a primary key'
);

SELECT columns_are(:'schema'::name, 'levels'::name, ARRAY[
    'feed_index'::name,
    'level_id'::name,
    'level_index'::name,
    'level_name'::name
]);

SELECT has_column(       :'schema', 'levels', 'feed_index', 'Column gtfs.levels.feed_index should exist');
SELECT col_type_is(      :'schema', 'levels', 'feed_index', 'integer', 'Column gtfs.levels.feed_index should be type integer');
SELECT col_not_null(     :'schema', 'levels', 'feed_index', 'Column gtfs.levels.feed_index should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'levels', 'feed_index', 'Column gtfs.levels.feed_index should not  have a default');

SELECT has_column(       :'schema', 'levels', 'level_id', 'Column gtfs.levels.level_id should exist');
SELECT col_type_is(      :'schema', 'levels', 'level_id', 'text', 'Column gtfs.levels.level_id should be type text');
SELECT col_not_null(     :'schema', 'levels', 'level_id', 'Column gtfs.levels.level_id should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'levels', 'level_id', 'Column gtfs.levels.level_id should not  have a default');

SELECT has_column(       :'schema', 'levels', 'level_index', 'Column gtfs.levels.level_index should exist');
SELECT col_type_is(      :'schema', 'levels', 'level_index', 'double precision', 'Column gtfs.levels.level_index should be type double precision');
SELECT col_not_null(     :'schema', 'levels', 'level_index', 'Column gtfs.levels.level_index should not allow NULL');
SELECT col_hasnt_default(:'schema', 'levels', 'level_index', 'Column gtfs.levels.level_index should not  have a default');

SELECT has_column(       :'schema', 'levels', 'level_name', 'Column gtfs.levels.level_name should exist');
SELECT col_type_is(      :'schema', 'levels', 'level_name', 'text', 'Column gtfs.levels.level_name should be type text');
SELECT col_is_null(      :'schema', 'levels', 'level_name', 'Column gtfs.levels.level_name should allow NULL');
SELECT col_hasnt_default(:'schema', 'levels', 'level_name', 'Column gtfs.levels.level_name should not  have a default');

SELECT * FROM finish();
ROLLBACK;
