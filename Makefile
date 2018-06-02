SHELL = bash

TABLES = stop_times trips routes \
	calendar_dates calendar \
	shapes stops \
	transfers frequencies \
	fare_attributes fare_rules agency feed_info

PGUSER ?= $(USER)
PGDATABASE ?= $(USER)
PSQL = psql $(PSQLFLAGS)

.PHONY: all load vacuum init clean \
	drop_constraints add_constraints \
	drop_indices add_indices \
	add_triggers drop_triggers

all:

add_constraints add_indices add_triggers: add_%: sql/%.sql
	$(PSQL) -f $<

drop_indices drop_constraints drop_triggers: drop_%: sql/drop_%.sql
	$(PSQL) -f $<

load: $(GTFS)
	$(SHELL) src/load.sh $(GTFS)
	@$(PSQL) -tAc "SELECT 'loaded feed with index: ' || MAX(feed_index)::text FROM gtfs_feed_info"

vacuum: ; $(PSQL) -c "VACUUM ANALYZE"

clean:
	[[ $(words $(FEED_INDEX)) -eq 1 ]] && echo $(TABLES) | \
	sed 's/\([a-z_]*\)/DELETE FROM gtfs_\1 WHERE feed_index = $(FEED_INDEX);/g' | \
	$(PSQL)

init: sql/schema.sql
	$(PSQL) -f $<
	$(PSQL) -c "\copy gtfs_route_types FROM 'data/route_types.txt'"
	$(PSQL) -f sql/constraints.sql
