SET search_path TO tap, public;
SELECT plan(3);
select has_function(:'schema', 'safe_locate', 'has function safe_locate');
select has_function(:'schema', 'dist_insert', 'has function dist_insert');
select has_function(:'schema', 'dist_update', 'has function dist_update');
SELECT * FROM finish();
