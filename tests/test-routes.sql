SET search_path TO tap, public;
SELECT plan(24);
SELECT has_table(:'schema', 'routes', 'table routes exists');
SELECT has_pk(:'schema', 'routes', 'table routes has primary key');
SELECT has_column(:'schema', 'routes', 'feed_index', 'table routes has column feed_index');
SELECT col_type_is(:'schema', 'routes', 'feed_index', 'integer', 'column routes.feed_index is integer');
SELECT has_column(:'schema', 'routes', 'route_id', 'table routes has column route_id');
SELECT col_type_is(:'schema', 'routes', 'route_id', 'text', 'column routes.route_id is text');
SELECT has_column(:'schema', 'routes', 'agency_id', 'table routes has column agency_id');
SELECT col_type_is(:'schema', 'routes', 'agency_id', 'text', 'column routes.agency_id is text');
SELECT has_column(:'schema', 'routes', 'route_short_name', 'table routes has column route_short_name');
SELECT col_type_is(:'schema', 'routes', 'route_short_name', 'text', 'column routes.route_short_name is text');
SELECT has_column(:'schema', 'routes', 'route_long_name', 'table routes has column route_long_name');
SELECT col_type_is(:'schema', 'routes', 'route_long_name', 'text', 'column routes.route_long_name is text');
SELECT has_column(:'schema', 'routes', 'route_desc', 'table routes has column route_desc');
SELECT col_type_is(:'schema', 'routes', 'route_desc', 'text', 'column routes.route_desc is text');
SELECT has_column(:'schema', 'routes', 'route_type', 'table routes has column route_type');
SELECT col_type_is(:'schema', 'routes', 'route_type', 'integer', 'column routes.route_type is integer');
SELECT has_column(:'schema', 'routes', 'route_url', 'table routes has column route_url');
SELECT col_type_is(:'schema', 'routes', 'route_url', 'text', 'column routes.route_url is text');
SELECT has_column(:'schema', 'routes', 'route_color', 'table routes has column route_color');
SELECT col_type_is(:'schema', 'routes', 'route_color', 'text', 'column routes.route_color is text');
SELECT has_column(:'schema', 'routes', 'route_text_color', 'table routes has column route_text_color');
SELECT col_type_is(:'schema', 'routes', 'route_text_color', 'text', 'column routes.route_text_color is text');
SELECT has_column(:'schema', 'routes', 'route_sort_order', 'table routes has column route_sort_order');
SELECT col_type_is(:'schema', 'routes', 'route_sort_order', 'integer', 'column routes.route_sort_order is integer');
SELECT * FROM finish();
