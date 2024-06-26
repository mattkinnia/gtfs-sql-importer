SET search_path TO tap, public;
SELECT plan(18);
SELECT has_table(:'schema', 'transfers', 'table transfers exists');
SELECT has_pk(:'schema', 'transfers', 'table transfers has primary key');
SELECT has_column(:'schema', 'transfers', 'feed_index', 'table transfers has column feed_index');
SELECT col_type_is(:'schema', 'transfers', 'feed_index', 'integer', 'column transfers.feed_index is integer');
SELECT has_column(:'schema', 'transfers', 'from_stop_id', 'table transfers has column from_stop_id');
SELECT col_type_is(:'schema', 'transfers', 'from_stop_id', 'text', 'column transfers.from_stop_id is text');
SELECT has_column(:'schema', 'transfers', 'to_stop_id', 'table transfers has column to_stop_id');
SELECT col_type_is(:'schema', 'transfers', 'to_stop_id', 'text', 'column transfers.to_stop_id is text');
SELECT has_column(:'schema', 'transfers', 'transfer_type', 'table transfers has column transfer_type');
SELECT col_type_is(:'schema', 'transfers', 'transfer_type', 'integer', 'column transfers.transfer_type is integer');
SELECT has_column(:'schema', 'transfers', 'min_transfer_time', 'table transfers has column min_transfer_time');
SELECT col_type_is(:'schema', 'transfers', 'min_transfer_time', 'integer', 'column transfers.min_transfer_time is integer');
SELECT has_column(:'schema', 'transfers', 'from_route_id', 'table transfers has column from_route_id');
SELECT col_type_is(:'schema', 'transfers', 'from_route_id', 'text', 'column transfers.from_route_id is text');
SELECT has_column(:'schema', 'transfers', 'to_route_id', 'table transfers has column to_route_id');
SELECT col_type_is(:'schema', 'transfers', 'to_route_id', 'text', 'column transfers.to_route_id is text');
SELECT has_column(:'schema', 'transfers', 'service_id', 'table transfers has column service_id');
SELECT col_type_is(:'schema', 'transfers', 'service_id', 'text', 'column transfers.service_id is text');
SELECT * FROM finish();
