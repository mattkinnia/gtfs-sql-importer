BEGIN;
SET search_path TO tap, public;
SELECT plan(11);

SELECT has_table(
    :'schema', 'timepoints',
    'Should have table gtfs.timepoints'
);

SELECT has_pk(
    :'schema', 'timepoints',
    'Table gtfs.timepoints should have a primary key'
);

SELECT columns_are(:'schema'::name, 'timepoints'::name, ARRAY[
    'timepoint'::name,
    'description'::name
]);

SELECT has_column(       :'schema', 'timepoints', 'timepoint', 'Column gtfs.timepoints.timepoint should exist');
SELECT col_type_is(      :'schema', 'timepoints', 'timepoint', 'integer', 'Column gtfs.timepoints.timepoint should be type integer');
SELECT col_not_null(     :'schema', 'timepoints', 'timepoint', 'Column gtfs.timepoints.timepoint should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'timepoints', 'timepoint', 'Column gtfs.timepoints.timepoint should not  have a default');

SELECT has_column(       :'schema', 'timepoints', 'description', 'Column gtfs.timepoints.description should exist');
SELECT col_type_is(      :'schema', 'timepoints', 'description', 'text', 'Column gtfs.timepoints.description should be type text');
SELECT col_is_null(      :'schema', 'timepoints', 'description', 'Column gtfs.timepoints.description should allow NULL');
SELECT col_hasnt_default(:'schema', 'timepoints', 'description', 'Column gtfs.timepoints.description should not  have a default');

SELECT * FROM finish();
ROLLBACK;
