SHELL = bash
# add TRANSITFEEDS api integration

DATABASE = 
PSQLFLAGS =
PSQL = psql $(DATABASE) $(PSQLFLAGS)

.PHONY: all load vacuum init drop_constraints add_constraints drop_indices add_indices

all:

add_constraints add_indices: add_%: sql/%.sql
	$(PSQL) -f $<

drop_constraints drop_indices: drop_%: sql/drop_%.sql
	$(PSQL) -f $<

load: $(GTFS)
	$(SHELL) src/load.sh $(GTFS) $(DATABASE) $(PSQLFLAGS)
	$(PSQL) -f sql/shape_geoms.sql

vacuum: ; $(PSQL) -c "VACUUM ANALYZE"

init: sql/schema.sql
	-createdb $(DATABASE) && $(PSQL) -c "CREATE EXTENSION postgis"
	$(PSQL) -f $<
	$(PSQL) -c "\copy gtfs_route_types FROM 'data/route_types.txt'"
	$(PSQL) -f sql/constraints.sql
