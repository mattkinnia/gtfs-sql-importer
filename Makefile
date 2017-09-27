SHELL = bash

TABLES = stop_times trips routes \
	calendar_dates calendar \
	shapes stops \
	transfers frequencies \
	fare_attributes fare_rules agency feed_info

PG_DATABASE ?= 
PSQLFLAGS =

ifdef PG_HOST
PSQLFLAGS += --host=$(PG_HOST)
endif

ifdef PG_PORT
PSQLFLAGS += --port=$(PG_USER)
endif

ifdef PG_USER
PSQLFLAGS += --username=$(PG_USER)
endif

PSQL = psql $(PG_DATABASE) $(PSQLFLAGS)

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
	$(SHELL) src/load.sh $(GTFS) $(PG_DATABASE) $(PSQLFLAGS)
	@$(PSQL) -tAc "SELECT 'loaded feed with index: ' || MAX(feed_index)::text FROM gtfs_feed_info"

vacuum: ; $(PSQL) -c "VACUUM ANALYZE"

clean:
	[[ $(words $(FEED_INDEX)) -eq 1 ]] && for t in $(TABLES); \
	do $(PSQL) -c "DELETE FROM gtfs_$${t} WHERE feed_index = $(FEED_INDEX)";\
	done;

init: sql/schema.sql
	-createdb $(PG_DATABASE)
	-$(PSQL) -c "CREATE EXTENSION postgis"
	$(PSQL) -f $<
	$(PSQL) -c "\copy gtfs_route_types FROM 'data/route_types.txt'"
	$(PSQL) -f sql/constraints.sql
