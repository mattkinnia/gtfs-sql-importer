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

.PHONY: all load clean vacuum init

all:

drop_constraints:
	$(PSQL) -f sql/drop_constraints.sql

add_constraints:
	$(PSQL) -f sql/constraints.sql

load: $(GTFS)
	sh load.sh $(GTFS) $(DATABASE) $(PSQLFLAGS)
	$(PSQL) -f sql/shape_geoms.sql

vacuum: ; $(PSQL) -c "VACUUM ANALYZE"

init: sql/schema.sql
	-createdb $(DATABASE) && $(PSQL) -c "CREATE EXTENSION postgis"
	$(PSQL) -f $<
	$(PSQL) -f sql/constraints.sql
