SET search_path to :schema, public;

DROP INDEX stops_geom_idx;

DROP INDEX calendar_dates_dateidx;

DROP INDEX shapes_shape_key;

DROP INDEX stop_times_key;
DROP INDEX arr_time_index;
DROP INDEX dep_time_index;

DROP INDEX shape_geoms_geom_idx;
