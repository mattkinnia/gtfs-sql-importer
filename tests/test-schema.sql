SET search_path TO tap, public;

SELECT plan(1);

SELECT has_schema('gtfs');

SELECT * FROM finish();
