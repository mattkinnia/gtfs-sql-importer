BEGIN;
SET search_path TO tap, public;
SELECT plan(55);

SELECT has_table(
    :'schema', 'pathways',
    'Should have table gtfs.pathways'
);

SELECT has_pk(
    :'schema', 'pathways',
    'Table gtfs.pathways should have a primary key'
);

SELECT columns_are(:'schema'::name, 'pathways'::name, ARRAY[
    'feed_index'::name,
    'pathway_id'::name,
    'from_stop_id'::name,
    'to_stop_id'::name,
    'pathway_mode'::name,
    'is_bidirectional'::name,
    'length'::name,
    'traversal_time'::name,
    'stair_count'::name,
    'max_slope'::name,
    'min_width'::name,
    'signposted_as'::name,
    'reversed_signposted_as'::name
]);

SELECT has_column(       :'schema', 'pathways', 'feed_index', 'Column gtfs.pathways.feed_index should exist');
SELECT col_type_is(      :'schema', 'pathways', 'feed_index', 'integer', 'Column gtfs.pathways.feed_index should be type integer');
SELECT col_not_null(     :'schema', 'pathways', 'feed_index', 'Column gtfs.pathways.feed_index should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'feed_index', 'Column gtfs.pathways.feed_index should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'pathway_id', 'Column gtfs.pathways.pathway_id should exist');
SELECT col_type_is(      :'schema', 'pathways', 'pathway_id', 'text', 'Column gtfs.pathways.pathway_id should be type text');
SELECT col_not_null(     :'schema', 'pathways', 'pathway_id', 'Column gtfs.pathways.pathway_id should be NOT NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'pathway_id', 'Column gtfs.pathways.pathway_id should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'from_stop_id', 'Column gtfs.pathways.from_stop_id should exist');
SELECT col_type_is(      :'schema', 'pathways', 'from_stop_id', 'text', 'Column gtfs.pathways.from_stop_id should be type text');
SELECT col_is_null(      :'schema', 'pathways', 'from_stop_id', 'Column gtfs.pathways.from_stop_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'from_stop_id', 'Column gtfs.pathways.from_stop_id should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'to_stop_id', 'Column gtfs.pathways.to_stop_id should exist');
SELECT col_type_is(      :'schema', 'pathways', 'to_stop_id', 'text', 'Column gtfs.pathways.to_stop_id should be type text');
SELECT col_is_null(      :'schema', 'pathways', 'to_stop_id', 'Column gtfs.pathways.to_stop_id should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'to_stop_id', 'Column gtfs.pathways.to_stop_id should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'pathway_mode', 'Column gtfs.pathways.pathway_mode should exist');
SELECT col_type_is(      :'schema', 'pathways', 'pathway_mode', 'integer', 'Column gtfs.pathways.pathway_mode should be type integer');
SELECT col_is_null(      :'schema', 'pathways', 'pathway_mode', 'Column gtfs.pathways.pathway_mode should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'pathway_mode', 'Column gtfs.pathways.pathway_mode should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'is_bidirectional', 'Column gtfs.pathways.is_bidirectional should exist');
SELECT col_type_is(      :'schema', 'pathways', 'is_bidirectional', 'integer', 'Column gtfs.pathways.is_bidirectional should be type integer');
SELECT col_is_null(      :'schema', 'pathways', 'is_bidirectional', 'Column gtfs.pathways.is_bidirectional should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'is_bidirectional', 'Column gtfs.pathways.is_bidirectional should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'length', 'Column gtfs.pathways.length should exist');
SELECT col_type_is(      :'schema', 'pathways', 'length', 'double precision', 'Column gtfs.pathways.length should be type double precision');
SELECT col_is_null(      :'schema', 'pathways', 'length', 'Column gtfs.pathways.length should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'length', 'Column gtfs.pathways.length should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'traversal_time', 'Column gtfs.pathways.traversal_time should exist');
SELECT col_type_is(      :'schema', 'pathways', 'traversal_time', 'integer', 'Column gtfs.pathways.traversal_time should be type integer');
SELECT col_is_null(      :'schema', 'pathways', 'traversal_time', 'Column gtfs.pathways.traversal_time should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'traversal_time', 'Column gtfs.pathways.traversal_time should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'stair_count', 'Column gtfs.pathways.stair_count should exist');
SELECT col_type_is(      :'schema', 'pathways', 'stair_count', 'integer', 'Column gtfs.pathways.stair_count should be type integer');
SELECT col_is_null(      :'schema', 'pathways', 'stair_count', 'Column gtfs.pathways.stair_count should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'stair_count', 'Column gtfs.pathways.stair_count should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'max_slope', 'Column gtfs.pathways.max_slope should exist');
SELECT col_type_is(      :'schema', 'pathways', 'max_slope', 'numeric', 'Column gtfs.pathways.max_slope should be type numeric');
SELECT col_is_null(      :'schema', 'pathways', 'max_slope', 'Column gtfs.pathways.max_slope should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'max_slope', 'Column gtfs.pathways.max_slope should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'min_width', 'Column gtfs.pathways.min_width should exist');
SELECT col_type_is(      :'schema', 'pathways', 'min_width', 'double precision', 'Column gtfs.pathways.min_width should be type double precision');
SELECT col_is_null(      :'schema', 'pathways', 'min_width', 'Column gtfs.pathways.min_width should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'min_width', 'Column gtfs.pathways.min_width should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'signposted_as', 'Column gtfs.pathways.signposted_as should exist');
SELECT col_type_is(      :'schema', 'pathways', 'signposted_as', 'text', 'Column gtfs.pathways.signposted_as should be type text');
SELECT col_is_null(      :'schema', 'pathways', 'signposted_as', 'Column gtfs.pathways.signposted_as should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'signposted_as', 'Column gtfs.pathways.signposted_as should not  have a default');

SELECT has_column(       :'schema', 'pathways', 'reversed_signposted_as', 'Column gtfs.pathways.reversed_signposted_as should exist');
SELECT col_type_is(      :'schema', 'pathways', 'reversed_signposted_as', 'text', 'Column gtfs.pathways.reversed_signposted_as should be type text');
SELECT col_is_null(      :'schema', 'pathways', 'reversed_signposted_as', 'Column gtfs.pathways.reversed_signposted_as should allow NULL');
SELECT col_hasnt_default(:'schema', 'pathways', 'reversed_signposted_as', 'Column gtfs.pathways.reversed_signposted_as should not  have a default');

SELECT * FROM finish();
ROLLBACK;
