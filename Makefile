SHELL = bash
# add TRANSITFEEDS api integration

DATABASE = 
PSQLFLAGS =
PSQL = psql $(DATABASE) $(PSQLFLAGS)

files = agency \
	calendar \
	calendar_dates \
	routes \
	shapes \
	stop_times \
	stops \
	trips \
	transfers \
	frequencies \
	feed_info \
	fare_attributes \
	fare_rules

.PHONY: load vacuum init

load: $(GTFS)
	$(PSQL) -f sql/drop_constraints.sql
	sh load.sh $(GTFS) $(DATABASE) $(PSQLFLAGS)
	$(PSQL) -f sql/constraints.sql
	$(PSQL) -f sql/shape_geoms.sql

vacuum: ; $(PSQL) -c "VACUUM ANALYZE"

init: sql/schema.sql
	createdb $(DATABASE) || echo ''
	$(PSQL) -f $<
	$(PSQL) -f sql/constraints.sql
