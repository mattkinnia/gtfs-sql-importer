SET search_path TO tap, public;
SELECT plan(51);
SELECT has_table(:'schema', 'stops', 'table stops exists');
SELECT has_pk(:'schema', 'stops', 'table stops has primary key');
SELECT has_column(:'schema', 'stops', 'feed_index', 'table stops has column feed_index');
SELECT col_type_is(:'schema', 'stops', 'feed_index', 'integer', 'column stops.feed_index is integer');
SELECT has_column(:'schema', 'stops', 'stop_id', 'table stops has column stop_id');
SELECT col_type_is(:'schema', 'stops', 'stop_id', 'text', 'column stops.stop_id is text');
SELECT has_column(:'schema', 'stops', 'stop_name', 'table stops has column stop_name');
SELECT col_type_is(:'schema', 'stops', 'stop_name', 'text', 'column stops.stop_name is text');
SELECT has_column(:'schema', 'stops', 'stop_desc', 'table stops has column stop_desc');
SELECT col_type_is(:'schema', 'stops', 'stop_desc', 'text', 'column stops.stop_desc is text');
SELECT has_column(:'schema', 'stops', 'stop_lat', 'table stops has column stop_lat');
SELECT col_type_is(:'schema', 'stops', 'stop_lat', 'double precision', 'column stops.stop_lat is double precision');
SELECT has_column(:'schema', 'stops', 'stop_lon', 'table stops has column stop_lon');
SELECT col_type_is(:'schema', 'stops', 'stop_lon', 'double precision', 'column stops.stop_lon is double precision');
SELECT has_column(:'schema', 'stops', 'zone_id', 'table stops has column zone_id');
SELECT col_type_is(:'schema', 'stops', 'zone_id', 'text', 'column stops.zone_id is text');
SELECT has_column(:'schema', 'stops', 'stop_url', 'table stops has column stop_url');
SELECT col_type_is(:'schema', 'stops', 'stop_url', 'text', 'column stops.stop_url is text');
SELECT has_column(:'schema', 'stops', 'stop_code', 'table stops has column stop_code');
SELECT col_type_is(:'schema', 'stops', 'stop_code', 'text', 'column stops.stop_code is text');
SELECT has_column(:'schema', 'stops', 'stop_street', 'table stops has column stop_street');
SELECT col_type_is(:'schema', 'stops', 'stop_street', 'text', 'column stops.stop_street is text');
SELECT has_column(:'schema', 'stops', 'stop_city', 'table stops has column stop_city');
SELECT col_type_is(:'schema', 'stops', 'stop_city', 'text', 'column stops.stop_city is text');
SELECT has_column(:'schema', 'stops', 'stop_region', 'table stops has column stop_region');
SELECT col_type_is(:'schema', 'stops', 'stop_region', 'text', 'column stops.stop_region is text');
SELECT has_column(:'schema', 'stops', 'stop_postcode', 'table stops has column stop_postcode');
SELECT col_type_is(:'schema', 'stops', 'stop_postcode', 'text', 'column stops.stop_postcode is text');
SELECT has_column(:'schema', 'stops', 'stop_country', 'table stops has column stop_country');
SELECT col_type_is(:'schema', 'stops', 'stop_country', 'text', 'column stops.stop_country is text');
SELECT has_column(:'schema', 'stops', 'stop_timezone', 'table stops has column stop_timezone');
SELECT col_type_is(:'schema', 'stops', 'stop_timezone', 'text', 'column stops.stop_timezone is text');
SELECT has_column(:'schema', 'stops', 'direction', 'table stops has column direction');
SELECT col_type_is(:'schema', 'stops', 'direction', 'text', 'column stops.direction is text');
SELECT has_column(:'schema', 'stops', 'position', 'table stops has column position');
SELECT col_type_is(:'schema', 'stops', 'position', 'text', 'column stops.position is text');
SELECT has_column(:'schema', 'stops', 'parent_station', 'table stops has column parent_station');
SELECT col_type_is(:'schema', 'stops', 'parent_station', 'text', 'column stops.parent_station is text');
SELECT has_column(:'schema', 'stops', 'wheelchair_boarding', 'table stops has column wheelchair_boarding');
SELECT col_type_is(:'schema', 'stops', 'wheelchair_boarding', 'integer', 'column stops.wheelchair_boarding is integer');
SELECT has_column(:'schema', 'stops', 'wheelchair_accessible', 'table stops has column wheelchair_accessible');
SELECT col_type_is(:'schema', 'stops', 'wheelchair_accessible', 'integer', 'column stops.wheelchair_accessible is integer');
SELECT has_column(:'schema', 'stops', 'location_type', 'table stops has column location_type');
SELECT col_type_is(:'schema', 'stops', 'location_type', 'integer', 'column stops.location_type is integer');
SELECT has_column(:'schema', 'stops', 'vehicle_type', 'table stops has column vehicle_type');
SELECT col_type_is(:'schema', 'stops', 'vehicle_type', 'integer', 'column stops.vehicle_type is integer');
SELECT has_column(:'schema', 'stops', 'platform_code', 'table stops has column platform_code');
SELECT col_type_is(:'schema', 'stops', 'platform_code', 'text', 'column stops.platform_code is text');
SELECT has_column(:'schema', 'stops', 'the_geom', 'table stops has column the_geom');
SELECT col_type_is(:'schema', 'stops', 'the_geom', 'geometry(Point,4326)', 'column stops.the_geom is geometry(Point,4326)');
SELECT is_indexed(:'schema', 'stops', ARRAY['the_geom']);
SELECT * FROM finish();
