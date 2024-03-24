BEGIN;
CREATE SCHEMA IF NOT EXISTS :schema;
SET search_path to :schema, public;

CREATE TABLE feed_info (
  feed_index serial PRIMARY KEY, -- tracks uploads, avoids key collisions
  feed_publisher_name text not null,
  feed_publisher_url text not null,
  feed_lang text not null,
  default_lang text default null,
  feed_start_date date default null,
  feed_end_date date default null,
  feed_version text default null,
  -- unofficial features
  feed_download_date date,
  feed_file text,
  feed_timezone text default null,
  feed_id text default null,
  feed_contact_url text default null,
  feed_contact_email text default null,
  CONSTRAINT feed_file_uniq UNIQUE (feed_file)
);

CREATE TABLE agency (
  feed_index integer NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  agency_id text default '',
  agency_name text not null,
  agency_url text not  null,
  agency_timezone text not null,
  -- optional
  agency_lang text,
  agency_phone text,
  agency_fare_url text,
  agency_email text,
  bikes_policy_url text,
  CONSTRAINT agency_pkey PRIMARY KEY (feed_index, agency_id)
);

--related to calendar_dates(exception_type)
CREATE TABLE exception_types (
  exception_type int PRIMARY KEY,
  description text
);

--related to stops(wheelchair_accessible)
CREATE TABLE wheelchair_accessible (
  wheelchair_accessible int PRIMARY KEY,
  description text
);

--related to stops(wheelchair_boarding)
CREATE TABLE wheelchair_boardings (
  wheelchair_boarding int PRIMARY KEY,
  description text
);

CREATE TABLE pickup_dropoff_types (
  type_id int PRIMARY KEY,
  description text
);

CREATE TABLE transfer_types (
  transfer_type int PRIMARY KEY,
  description text
);

--related to stops(location_type)
CREATE TABLE location_types (
  location_type int PRIMARY KEY,
  description text
);

-- related to stop_times(timepoint)
CREATE TABLE timepoints (
  timepoint int PRIMARY KEY,
  description text
);

CREATE TABLE continuous_pickup (
  continuous_pickup int PRIMARY KEY,
  description text
);

CREATE TABLE continuous_drop_off (
  continuous_drop_off int PRIMARY KEY,
  description text
);

CREATE TABLE calendar (
  feed_index integer NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  service_id text,
  monday int not null,
  tuesday int not null,
  wednesday int not null,
  thursday int not null,
  friday int not null,
  saturday int not null,
  sunday int not null,
  start_date date not null,
  end_date date not null,
  CONSTRAINT calendar_pkey PRIMARY KEY (feed_index, service_id)
);

CREATE OR REPLACE FUNCTION feed_date_update()
  RETURNS TRIGGER AS $$
  BEGIN
    UPDATE feed_info fi SET
      feed_start_date = CASE WHEN feed_start_date IS NULL THEN start_date ELSE feed_start_date END,
      feed_end_date   = CASE WHEN feed_end_date IS NULL THEN end_date ELSE feed_end_date END
    FROM (
      SELECT feed_index, MIN(start_date) start_date, MAX(end_date) end_date
      FROM inserted
      GROUP BY 1
    ) a
    WHERE fi.feed_index = a.feed_index
    AND (fi.feed_start_date IS NULL OR fi.feed_end_date IS NULL);
    RETURN NULL;
  END;
  $$ LANGUAGE plpgsql
  SET search_path = :schema, public;

COMMENT ON FUNCTION feed_date_update IS
  'Update start/end dates in feed_info after inserting info calendar_dates. Do not overwrite existing dates';

CREATE TRIGGER calendar_trigger AFTER INSERT ON calendar
  REFERENCING NEW TABLE AS inserted
  FOR EACH STATEMENT EXECUTE PROCEDURE feed_date_update();

CREATE TABLE levels (
  feed_index integer NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  level_id text not null,
  level_index double precision not null,
  level_name text,
  PRIMARY KEY (feed_index, level_id)
);

CREATE TABLE stops (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  stop_id text not null,
  stop_code text,
  stop_name text,
  stop_desc text,
  stop_lat double precision,
  stop_lon double precision,
  zone_id text,
  stop_url text,
  stop_street text,
  stop_city text,
  stop_region text,
  stop_postcode text,
  stop_country text,
  stop_timezone text,
  direction text,
  position text,
  parent_station text,
  wheelchair_boarding integer REFERENCES wheelchair_boardings (wheelchair_boarding),
  wheelchair_accessible integer REFERENCES wheelchair_accessible (wheelchair_accessible),
  -- optional
  location_type integer REFERENCES location_types (location_type),
  vehicle_type int,
  level_id text,
  platform_code text,
  the_geom geometry(point, 4326),
  CONSTRAINT stops_level_id_fkey FOREIGN KEY (feed_index, level_id)
    REFERENCES levels (feed_index, level_id),
  CONSTRAINT stops_pkey PRIMARY KEY (feed_index, stop_id)
);

-- trigger the_geom update with lat or lon inserted
CREATE OR REPLACE FUNCTION stop_geom_update() RETURNS TRIGGER AS $stop_geom$
  BEGIN
    NEW.the_geom = ST_SetSRID(ST_MakePoint(NEW.stop_lon, NEW.stop_lat), 4326);
    RETURN NEW;
  END;
$stop_geom$ LANGUAGE plpgsql;

CREATE TRIGGER stop_geom_trigger BEFORE INSERT OR UPDATE ON stops
    FOR EACH ROW EXECUTE PROCEDURE stop_geom_update();

CREATE TABLE route_types (
  route_type int PRIMARY KEY,
  description text
);

CREATE TABLE routes (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  route_id text not null,
  agency_id text,
  route_short_name text default '',
  route_long_name text default '',
  route_desc text,
  route_type int not null,
  route_url text,
  route_color text,
  route_text_color text,
  route_sort_order integer default null,
  continuous_pickup int default null REFERENCES continuous_pickup (continuous_pickup),
  continuous_drop_off int default null REFERENCES continuous_drop_off (continuous_drop_off),
  CONSTRAINT routes_agency_id_fkey FOREIGN KEY (feed_index, agency_id)
    REFERENCES agency (feed_index, agency_id),
  CONSTRAINT route_types_fkey FOREIGN KEY (route_type)
    REFERENCES route_types (route_type),
  CONSTRAINT routes_pkey PRIMARY KEY (feed_index, route_id)
);
  
CREATE TABLE calendar_dates (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  service_id text not null,
  date date not null,
  exception_type int REFERENCES exception_types (exception_type),
  CONSTRAINT calendar_dates_service_id_fkey FOREIGN KEY (feed_index, service_id)
    REFERENCES calendar (feed_index, service_id),
  CONSTRAINT calendar_dates_pkey PRIMARY KEY (feed_index, service_id, date)
);

CREATE TABLE payment_methods (
  payment_method int PRIMARY KEY,
  description text
);

CREATE TABLE fare_attributes (
  feed_index int NOT NULL REFERENCES feed_info (feed_index),
  fare_id text not null,
  price double precision not null,
  currency_type text not null,
  payment_method int NOT NULL REFERENCES payment_methods,
  transfers int NOT NULL,
  transfer_duration int,
  -- unofficial features
  agency_id text,
  CONSTRAINT fare_attributes_fkey FOREIGN KEY (feed_index, agency_id)
    REFERENCES agency (feed_index, agency_id),
  CONSTRAINT fare_attributes_pkey PRIMARY KEY (feed_index, fare_id)
);

CREATE TABLE fare_rules (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  fare_id text NOT NULL,
  route_id text,
  origin_id text,
  destination_id text,
  contains_id text,
  -- unofficial features
  service_id text,
  CONSTRAINT fare_rules_service_fkey FOREIGN KEY (feed_index, service_id)
    REFERENCES calendar (feed_index, service_id),
  CONSTRAINT fare_rules_fare_id_fkey FOREIGN KEY (feed_index, fare_id)
    REFERENCES fare_attributes (feed_index, fare_id),
  CONSTRAINT fare_rules_route_id_fkey FOREIGN KEY (feed_index, route_id)
    REFERENCES routes (feed_index, route_id),
  CONSTRAINT fare_rules_pkey
    PRIMARY KEY (feed_index, fare_id, route_id, origin_id, destination_id)
);

CREATE TABLE shapes (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  shape_id text not null,
  shape_pt_lat double precision not null,
  shape_pt_lon double precision not null,
  shape_pt_sequence int not null,
  -- optional
  shape_dist_traveled double precision,
  CONSTRAINT shapes_pk PRIMARY KEY (feed_index, shape_id, shape_pt_sequence)
);

-- Create new table to store the shape geometries
CREATE TABLE shape_geoms (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  shape_id text not null,
  length numeric(12, 2) not null,
  the_geom geometry(LineString, 4326) not null,
  CONSTRAINT shape_geom_pkey PRIMARY KEY (feed_index, shape_id)
);

CREATE TABLE trips (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  route_id text not null,
  service_id text not null,
  trip_id text not null,
  trip_headsign text,
  direction_id int,
  block_id text,
  shape_id text,
  trip_short_name text,
  wheelchair_accessible int REFERENCES wheelchair_accessible(wheelchair_accessible),
  -- unofficial features
  direction text,
  schd_trip_id text,
  trip_type text,
  exceptional int,
  bikes_allowed int,
  CONSTRAINT trips_route_id_fkey FOREIGN KEY (feed_index, route_id)
    REFERENCES routes (feed_index, route_id),
  CONSTRAINT trips_calendar_fkey FOREIGN KEY (feed_index, service_id)
    REFERENCES calendar (feed_index, service_id),
  CONSTRAINT trips_pkey PRIMARY KEY (feed_index, trip_id)
);

CREATE TABLE stop_times (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  trip_id text not null,
  -- Check that casting to time interval works.
  -- Interval used rather than Time because: 
  -- "For times occurring after midnight on the service day, 
  -- enter the time as a value greater than 24:00:00" 
  -- https://developers.google.com/transit/gtfs/reference#stop_timestxt
  -- conversion tool: https://github.com/Bus-Data-NYC/nyc-bus-stats/blob/master/sql/util.sql#L48
  arrival_time interval CHECK (arrival_time::interval = arrival_time::interval),
  departure_time interval CHECK (departure_time::interval = departure_time::interval),
  stop_id text,
  stop_sequence int not null,
  stop_headsign text,
  pickup_type int REFERENCES pickup_dropoff_types(type_id),
  drop_off_type int REFERENCES pickup_dropoff_types(type_id),
  continuous_pickup int default null REFERENCES continuous_pickup (continuous_pickup),
  continuous_drop_off int default null REFERENCES continuous_drop_off (continuous_drop_off),
  shape_dist_traveled numeric(10, 2),
  timepoint int REFERENCES timepoints (timepoint),

  -- unofficial features
  -- the following are not in the spec
  arrival_time_seconds int default null,
  departure_time_seconds int default null,
  CONSTRAINT stop_times_trips_fkey FOREIGN KEY (feed_index, trip_id)
    REFERENCES trips (feed_index, trip_id),
  CONSTRAINT stop_times_stops_fkey FOREIGN KEY (feed_index, stop_id)
    REFERENCES stops (feed_index, stop_id),
  CONSTRAINT stop_times_pkey PRIMARY KEY (feed_index, trip_id, stop_sequence)
);

-- "Safely" locate a point on a (possibly complicated) line by using minimum and maximum distances.
-- Unlike st_LineLocatePoint, this accepts and returns absolute distances, not fractions
CREATE OR REPLACE FUNCTION safe_locate
  (route geometry, point geometry, start numeric, finish numeric, length numeric)
  RETURNS numeric AS $$
    -- Multiply the fractional distance also the substring by the substring,
    -- then add the start distance
    SELECT LEAST(length, GREATEST(0, start) + ST_LineLocatePoint(
      ST_LineSubstring(route, GREATEST(0, start / length), LEAST(1, finish / length)),
      point
    )::numeric * (
      -- The absolute distance between start and finish
      LEAST(length, finish) - GREATEST(0, start)
    ));
  $$ LANGUAGE SQL;

CREATE TABLE frequencies (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  trip_id text,
  start_time text not null CHECK (start_time::interval = start_time::interval),
  end_time text not null CHECK (end_time::interval = end_time::interval),
  headway_secs int not null,
  exact_times int,
  start_time_seconds int,
  end_time_seconds int,
  CONSTRAINT frequencies_trip_fkey FOREIGN KEY (feed_index, trip_id)
    REFERENCES trips (feed_index, trip_id),
  CONSTRAINT frequencies_pkey PRIMARY KEY (feed_index, trip_id, start_time)
);

CREATE TABLE transfers (
  feed_index int NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  from_stop_id text not null,
  to_stop_id text not null,
  transfer_type int not null REFERENCES transfer_types(transfer_type),
  min_transfer_time int,
  -- Unofficial fields
  from_route_id text default null,
  to_route_id text default null,
  service_id text default null,
  CONSTRAINT transfers_from_stop_fkey FOREIGN KEY (feed_index, from_stop_id)
    REFERENCES stops (feed_index, stop_id),
  CONSTRAINT transfers_to_stop_fkey FOREIGN KEY (feed_index, to_stop_id)
    REFERENCES stops (feed_index, stop_id),
  CONSTRAINT transfers_from_route_fkey FOREIGN KEY (feed_index, from_route_id)
    REFERENCES routes (feed_index, route_id),
  CONSTRAINT transfers_to_route_fkey FOREIGN KEY (feed_index, to_route_id)
    REFERENCES routes (feed_index, route_id),
  CONSTRAINT transfers_service_fkey FOREIGN KEY (feed_index, service_id)
    REFERENCES calendar (feed_index, service_id),
  CONSTRAINT transfers_pkey PRIMARY KEY (feed_index, from_stop_id, to_stop_id)
);

CREATE TABLE pathway_modes (
  pathway_mode integer PRIMARY KEY,
  description text
);

CREATE TABLE pathways (
  feed_index integer NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  pathway_id text not null,
  from_stop_id text not null,
  to_stop_id text not null,
  pathway_mode integer not null REFERENCES pathway_modes (pathway_mode),
  is_bidirectional integer not null,
  length double precision,
  traversal_time integer,
  stair_count integer,
  max_slope numeric,
  min_width double precision,
  signposted_as text,
  reversed_signposted_as text,
  PRIMARY KEY (feed_index, pathway_id)
);

CREATE TABLE translations (
  feed_index integer NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  table_name text not null,
  field_name text not null,
  language text not null,
  translation text not null,
  record_id text,
  record_sub_id text,
  field_value text,
  PRIMARY KEY (feed_index, table_name, field_value, language)
);

CREATE TABLE attributions (
  feed_index integer NOT NULL REFERENCES feed_info (feed_index) ON DELETE CASCADE,
  attribution_id text,
  agency_id text,
  route_id text,
  trip_id text,
  organization_name text not null,
  is_producer boolean,
  is_operator boolean,
  is_authority boolean,
  attribution_url text,
  attribution_email text,
  attribution_phone text,
  CONSTRAINT attributions_trip_id_fkey FOREIGN KEY (feed_index, trip_id)
    REFERENCES trips (feed_index, trip_id),
  CONSTRAINT attributions_route_id_fkey FOREIGN KEY (feed_index, route_id)
    REFERENCES routes (feed_index, route_id),
  PRIMARY KEY (feed_index, attribution_id)
);

CREATE VIEW service_dates_view AS
SELECT 
    c.feed_index, c.service_id, d::date AS date
FROM 
    calendar c, generate_series(c.start_date::date, c.end_date::date, '1 day'::interval) AS d
WHERE 
    (
        (c.monday = 1 AND EXTRACT(ISODOW FROM d) = 1) OR
        (c.tuesday = 1 AND EXTRACT(ISODOW FROM d) = 2) OR
        (c.wednesday = 1 AND EXTRACT(ISODOW FROM d) = 3) OR
        (c.thursday = 1 AND EXTRACT(ISODOW FROM d) = 4) OR
        (c.friday = 1 AND EXTRACT(ISODOW FROM d) = 5) OR
        (c.saturday = 1 AND EXTRACT(ISODOW FROM d) = 6) OR
        (c.sunday = 1 AND EXTRACT(ISODOW FROM d) = 7)
    )
    AND NOT EXISTS (
        SELECT 1
        FROM calendar_dates cd
        WHERE cd.service_id = c.service_id 
        AND cd.date = d::date
        AND cd.exception_type = 2
    )
UNION
SELECT 
    c.feed_index, cd.service_id, cd.date
FROM 
    calendar c
JOIN 
    calendar_dates cd 
    ON c.service_id = cd.service_id 
    AND c.feed_index = cd.feed_index
WHERE 
    cd.exception_type = 1 
    AND c.start_date <= cd.date 
    AND cd.date <= c.end_date;

insert into exception_types (exception_type, description) values 
  (1, 'service has been added'),
  (2, 'service has been removed');

insert into transfer_types (transfer_type, description) VALUES
  (0,'Preferred transfer point'),
  (1,'Designated transfer point'),
  (2,'Transfer possible with min_transfer_time window'),
  (3,'Transfers forbidden');

insert into location_types(location_type, description) values 
  (0,'stop'),
  (1,'station'),
  (2,'station entrance'),
  (3,'generic node'),
  (4,'boarding area');

insert into wheelchair_boardings(wheelchair_boarding, description) values
   (0, 'No accessibility information available for the stop'),
   (1, 'At least some vehicles at this stop can be boarded by a rider in a wheelchair'),
   (2, 'Wheelchair boarding is not possible at this stop');

insert into wheelchair_accessible(wheelchair_accessible, description) values
  (0, 'No accessibility information available for this trip'),
  (1, 'The vehicle being used on this particular trip can accommodate at least one rider in a wheelchair'),
  (2, 'No riders in wheelchairs can be accommodated on this trip');

insert into pickup_dropoff_types (type_id, description) values
  (0,'Regularly Scheduled'),
  (1,'Not available'),
  (2,'Phone arrangement only'),
  (3,'Driver arrangement only');

insert into payment_methods (payment_method, description) values
  (0,'On Board'),
  (1,'Prepay');

insert into timepoints (timepoint, description) values
  (0, 'Times are considered approximate'),
  (1, 'Times are considered exact');

insert into continuous_pickup (continuous_pickup, description) values
  (0, 'Continuous stopping pickup'),
  (1, 'No continuous stopping pickup'),
  (2, 'Must phone agency to arrange continuous stopping pickup'),
  (3, 'Must coordinate with driver to arrange continuous stopping pickup');

insert into continuous_drop_off (continuous_drop_off, description) values
  (0, 'Continuous stopping drop-off'),
  (1, 'No continuous stopping drop-off'),
  (2, 'Must phone agency to arrange continuous stopping drop-off'),
  (3, 'Must coordinate with driver to arrange continuous stopping drop-off');

insert into pathway_modes (pathway_mode, description) values
  (1, 'walkway'),
  (2, 'stairs'),
  (3, 'moving sidewalk/travelator'),
  (4, 'escalator'),
  (5, 'elevator'),
  (6, 'fare gate (or payment gate)'),
  (7, 'exit gate');

COMMIT;
