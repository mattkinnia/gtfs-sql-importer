SET search_path TO tap, public;
SELECT plan(15);
SELECT has_table(:'schema', 'shapes', 'table shapes exists');
SELECT has_pk(:'schema', 'shapes', 'table shapes has primary key');
SELECT is_indexed(:'schema', 'shapes', ARRAY['shape_id']);
SELECT has_column(:'schema', 'shapes', 'feed_index', 'table shapes has column feed_index');
SELECT col_type_is(:'schema', 'shapes', 'feed_index', 'integer', 'column shapes.feed_index is integer');
SELECT has_column(:'schema', 'shapes', 'shape_id', 'table shapes has column shape_id');
SELECT col_type_is(:'schema', 'shapes', 'shape_id', 'text', 'column shapes.shape_id is text');
SELECT has_column(:'schema', 'shapes', 'shape_pt_lat', 'table shapes has column shape_pt_lat');
SELECT col_type_is(:'schema', 'shapes', 'shape_pt_lat', 'double precision', 'column shapes.shape_pt_lat is double precision');
SELECT has_column(:'schema', 'shapes', 'shape_pt_lon', 'table shapes has column shape_pt_lon');
SELECT col_type_is(:'schema', 'shapes', 'shape_pt_lon', 'double precision', 'column shapes.shape_pt_lon is double precision');
SELECT has_column(:'schema', 'shapes', 'shape_pt_sequence', 'table shapes has column shape_pt_sequence');
SELECT col_type_is(:'schema', 'shapes', 'shape_pt_sequence', 'integer', 'column shapes.shape_pt_sequence is integer');
SELECT has_column(:'schema', 'shapes', 'shape_dist_traveled', 'table shapes has column shape_dist_traveled');
SELECT col_type_is(:'schema', 'shapes', 'shape_dist_traveled', 'double precision', 'column shapes.shape_dist_traveled is double precision');
SELECT * FROM finish();