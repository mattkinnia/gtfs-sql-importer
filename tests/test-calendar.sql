SET search_path TO tap, public;
SELECT plan(25);

SELECT has_table(:'schema', 'calendar', 'table calendar exists');
SELECT has_pk(:'schema', 'calendar', 'table calendar has primary key');
SELECT is_indexed(:'schema', 'calendar', ARRAY['feed_index', 'service_id']);

SELECT has_column(:'schema', 'calendar', 'feed_index', 'table calendar has column feed_index');
SELECT col_type_is(:'schema', 'calendar', 'feed_index', 'integer', 'column calendar.feed_index is integer');
SELECT has_column(:'schema', 'calendar', 'service_id', 'table calendar has column service_id');
SELECT col_type_is(:'schema', 'calendar', 'service_id', 'text', 'column calendar.service_id is text');
SELECT has_column(:'schema', 'calendar', 'monday', 'table calendar has column monday');
SELECT col_type_is(:'schema', 'calendar', 'monday', 'integer', 'column calendar.monday is integer');
SELECT has_column(:'schema', 'calendar', 'tuesday', 'table calendar has column tuesday');
SELECT col_type_is(:'schema', 'calendar', 'tuesday', 'integer', 'column calendar.tuesday is integer');
SELECT has_column(:'schema', 'calendar', 'wednesday', 'table calendar has column wednesday');
SELECT col_type_is(:'schema', 'calendar', 'wednesday', 'integer', 'column calendar.wednesday is integer');
SELECT has_column(:'schema', 'calendar', 'thursday', 'table calendar has column thursday');
SELECT col_type_is(:'schema', 'calendar', 'thursday', 'integer', 'column calendar.thursday is integer');
SELECT has_column(:'schema', 'calendar', 'friday', 'table calendar has column friday');
SELECT col_type_is(:'schema', 'calendar', 'friday', 'integer', 'column calendar.friday is integer');
SELECT has_column(:'schema', 'calendar', 'saturday', 'table calendar has column saturday');
SELECT col_type_is(:'schema', 'calendar', 'saturday', 'integer', 'column calendar.saturday is integer');
SELECT has_column(:'schema', 'calendar', 'sunday', 'table calendar has column sunday');
SELECT col_type_is(:'schema', 'calendar', 'sunday', 'integer', 'column calendar.sunday is integer');
SELECT has_column(:'schema', 'calendar', 'start_date', 'table calendar has column start_date');
SELECT col_type_is(:'schema', 'calendar', 'start_date', 'date', 'column calendar.start_date is date');
SELECT has_column(:'schema', 'calendar', 'end_date', 'table calendar has column end_date');
SELECT col_type_is(:'schema', 'calendar', 'end_date', 'date', 'column calendar.end_date is date');
SELECT * FROM finish();
