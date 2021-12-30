SET search_path to :schema, public;

CREATE INDEX IF NOT EXISTS calendar_service_id
  ON :schema.calendar (feed_index, service_id);

CREATE INDEX IF NOT EXISTS stop_geom_idx
  ON stops USING GIST (the_geom);

CREATE INDEX IF NOT EXISTS calendar_dates_dateidx
  ON :schema.calendar_dates (date);

CREATE INDEX IF NOT EXISTS shapes_shape_key
  ON :schema.shapes (shape_id);

CREATE INDEX IF NOT EXISTS trips_service_id
  ON :schema.trips (feed_index, service_id);

CREATE INDEX IF NOT EXISTS stop_times_key
  ON :schema.stop_times (feed_index, trip_id, stop_id);

CREATE INDEX IF NOT EXISTS arr_time_index
  ON :schema.stop_times (arrival_time_seconds);

CREATE INDEX IF NOT EXISTS dep_time_index
  ON :schema.stop_times (departure_time_seconds);

CREATE INDEX IF NOT EXISTS shape_geoms_geom_idx
  ON shape_geoms USING GIST (the_geom);
