BEGIN;
SET search_path TO tap, public;
SELECT plan(35);

SELECT has_table(
    :'schema', 'translations',
    'Should have table gtfs.translations'
);

SELECT has_pk(
    :'schema', 'translations',
    'Table gtfs.translations should have a primary key'
);

SELECT columns_are(:'schema'::name, 'translations'::name, ARRAY[
    'feed_index'::name,
    'table_name'::name,
    'field_name'::name,
    'language'::name,
    'translation'::name,
    'record_id'::name,
    'record_sub_id'::name,
    'field_value'::name
]);

SELECT has_column(       :'schema', 'translations', 'feed_index', 'Column gtfs.translations.feed_index should exist');
SELECT col_type_is(      :'schema', 'translations', 'feed_index', 'integer', 'Column gtfs.translations.feed_index should be type integer');
SELECT col_not_null(     :'schema', 'translations', 'feed_index', 'Column gtfs.translations.feed_index should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'feed_index', 'Column gtfs.translations.feed_index should not  have a default');

SELECT has_column(       :'schema', 'translations', 'table_name', 'Column gtfs.translations.table_name should exist');
SELECT col_type_is(      :'schema', 'translations', 'table_name', 'text', 'Column gtfs.translations.table_name should be type text');
SELECT col_not_null(     :'schema', 'translations', 'table_name', 'Column gtfs.translations.table_name should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'table_name', 'Column gtfs.translations.table_name should not  have a default');

SELECT has_column(       :'schema', 'translations', 'field_name', 'Column gtfs.translations.field_name should exist');
SELECT col_type_is(      :'schema', 'translations', 'field_name', 'text', 'Column gtfs.translations.field_name should be type text');
SELECT col_not_null(     :'schema', 'translations', 'field_name', 'Column gtfs.translations.field_name should not allow NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'field_name', 'Column gtfs.translations.field_name should not  have a default');

SELECT has_column(       :'schema', 'translations', 'language', 'Column gtfs.translations.language should exist');
SELECT col_type_is(      :'schema', 'translations', 'language', 'text', 'Column gtfs.translations.language should be type text');
SELECT col_not_null(     :'schema', 'translations', 'language', 'Column gtfs.translations.language should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'language', 'Column gtfs.translations.language should not  have a default');

SELECT has_column(       :'schema', 'translations', 'translation', 'Column gtfs.translations.translation should exist');
SELECT col_type_is(      :'schema', 'translations', 'translation', 'text', 'Column gtfs.translations.translation should be type text');
SELECT col_not_null(     :'schema', 'translations', 'translation', 'Column gtfs.translations.translation should not allow NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'translation', 'Column gtfs.translations.translation should not  have a default');

SELECT has_column(       :'schema', 'translations', 'record_id', 'Column gtfs.translations.record_id should exist');
SELECT col_type_is(      :'schema', 'translations', 'record_id', 'text', 'Column gtfs.translations.record_id should be type text');
SELECT col_is_null(      :'schema', 'translations', 'record_id', 'Column gtfs.translations.record_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'record_id', 'Column gtfs.translations.record_id should not  have a default');

SELECT has_column(       :'schema', 'translations', 'record_sub_id', 'Column gtfs.translations.record_sub_id should exist');
SELECT col_type_is(      :'schema', 'translations', 'record_sub_id', 'text', 'Column gtfs.translations.record_sub_id should be type text');
SELECT col_is_null(      :'schema', 'translations', 'record_sub_id', 'Column gtfs.translations.record_sub_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'record_sub_id', 'Column gtfs.translations.record_sub_id should not  have a default');

SELECT has_column(       :'schema', 'translations', 'field_value', 'Column gtfs.translations.field_value should exist');
SELECT col_type_is(      :'schema', 'translations', 'field_value', 'text', 'Column gtfs.translations.field_value should be type text');
SELECT col_not_null(     :'schema', 'translations', 'field_value', 'Column gtfs.translations.field_value should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'translations', 'field_value', 'Column gtfs.translations.field_value should not  have a default');

SELECT * FROM finish();
ROLLBACK;
