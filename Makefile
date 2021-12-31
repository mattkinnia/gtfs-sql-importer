SHELL := /bin/bash

TABLES = stop_times trips routes \
	calendar_dates calendar \
	shapes stops \
	transfers frequencies \
	attributions translations pathways levels \
	fare_attributes fare_rules agency feed_info

SCHEMA = gtfs

SRID = 4326

psql = $(strip psql -v schema=$(SCHEMA))

.PHONY: all load vacuum init clean \
	test check truncate \
	drop_constraints add_constraints \
	drop_indices add_indices \
	add_triggers drop_triggers \
	drop_notnull add_notnull \
	$(addprefix load-,$(TABLES))

all:

add_constraints add_indices add_triggers add_notnull: add_%: sql/%.sql
	$(psql) -f $<

drop_indices drop_constraints drop_triggers drop_notnull: drop_%: sql/drop_%.sql
	$(psql) -f $<

load: $(addprefix load-,$(TABLES))
	$(psql) -v schema=$(SCHEMA) -v feed_file=$(GTFS) --set srid=$(SRID) -f sql/shape_geoms_populate.sql
	$(psql) -v schema=$(SCHEMA) -v feed_file=$(GTFS) --set srid=$(SRID) -f sql/stop_time_update_distance.sql
	@$(psql) -t -A -c "SELECT format('* loaded %s with feed index = %s', feed_file, feed_index) FROM $(SCHEMA).feed_info WHERE feed_file = '$(GTFS)'"

$(filter-out load-feed_info,$(addprefix load-,$(TABLES))): load-%: load-feed_info | $(GTFS)
	$(SHELL) src/load.sh $| $(SCHEMA) $*

load-feed_info: | $(GTFS) ## Insert row into feed_index, if necessary
	$(SHELL) ./src/load_feed_info.sh $| $(SCHEMA)

vacuum: ; $(psql) -c "VACUUM ANALYZE"

clean: ## Delete a feed from the DB. Relies on foreign keys for feed_index in each table
ifdef FEED_INDEX
	$(psql) -c "DELETE FROM $(SCHEMA).feed_info WHERE feed_index = $(FEED_INDEX)"
else
	$(error "make clean" requires FEED_INDEX)
endif

ifdef FEED_INDEX
check: ; prove -v --exec 'psql -qAt -v schema=$(SCHEMA) -v feed_index=$(FEED_INDEX) -f' $(wildcard tests/validity/*.sql)
endif

test: ; prove -f --exec 'psql -qAt -v schema=$(SCHEMA) -f' $(wildcard tests/*.sql)

truncate:
	for t in $(TABLES); do \
		echo "TRUNCATE TABLE $(SCHEMA).$$t RESTART IDENTITY CASCADE;"; done \
	| $(psql) -1

init: sql/schema.sql
	$(psql) -v ON_ERROR_STOP=on -f $<
	$(psql) -v ON_ERROR_STOP=on -c "\copy $(SCHEMA).route_types FROM 'data/route_types.txt'"
	$(psql) -v ON_ERROR_STOP=on -f sql/indices.sql
