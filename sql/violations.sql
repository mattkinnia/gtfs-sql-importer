SELECT 'gtfs.route_types_fkey', count(distinct (feed_index, route_type))
  FROM gtfs.routes a
    LEFT JOIN gtfs.route_types b using (route_type)
  WHERE b.description IS NULL;

SELECT 'gtfs.routes_fkey', count(distinct (feed_index, agency_id))
  FROM gtfs.routes a
    LEFT JOIN gtfs.agency b using (feed_index, agency_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs.calendar_fkey', count(distinct (feed_index, service_id))
  FROM gtfs.calendar_dates
    LEFT JOIN gtfs.calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

SELECT 'gtfs.fare_attributes_fkey', count(distinct (feed_index, agency_id))
  FROM gtfs.fare_attributes a
    LEFT JOIN gtfs.agency b using (feed_index, agency_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs.fare_rules_service_fkey', count(distinct (feed_index, service_id))
  FROM gtfs.fare_rules a
    LEFT JOIN gtfs.calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

SELECT 'gtfs.fare_rules_fare_id_fkey', count(distinct (feed_index, fare_id))
  FROM gtfs.fare_rules a
    LEFT JOIN gtfs.fare_attributes b using (feed_index, fare_id)
  WHERE b.price IS NULL;

SELECT 'gtfs.fare_rules_route_id_fkey', count(distinct (feed_index, route_id))
  FROM gtfs.fare_rules a
    LEFT JOIN gtfs.routes b using (feed_index, route_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs.trips_route_id_fkey', count(distinct (feed_index, route_id))
  FROM gtfs.trips a
    LEFT JOIN gtfs.routes b using (feed_index, route_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs.trips_calendar_fkey', count(distinct (feed_index, service_id))
  FROM gtfs.trips a
    LEFT JOIN gtfs.calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

SELECT 'gtfs.stop_times_trips_fkey', count(distinct (feed_index, trip_id))
  FROM gtfs.stop_times a
    LEFT JOIN gtfs.trips b using (feed_index, trip_id)
  WHERE b.service_id IS NULL;

SELECT 'gtfs.stop_times_stops_fkey', count(distinct (feed_index, stop_id))
  FROM gtfs.stop_times a
    LEFT JOIN gtfs.stops b using (feed_index, stop_id)
  WHERE coalesce(stop_lat, stop_lon) IS NULL;

SELECT 'gtfs.frequencies_trip_fkey', count(distinct (feed_index, trip_id))
  FROM gtfs.frequencies a
    LEFT JOIN gtfs.trips b using (feed_index, trip_id)
  WHERE b.service_id IS NULL;

SELECT 'gtfs.transfers_from_stop_fkey', count(distinct (a.feed_index, from_stop_id))
  FROM gtfs.transfers a
    LEFT JOIN gtfs.stops b on a.feed_index = b.feed_index and a.from_stop_id::text = b.stop_id::text
  WHERE coalesce(stop_lat, stop_lon) IS NULL;

SELECT 'gtfs.transfers_to_stop_fkey', count(distinct (a.feed_index, to_stop_id))
  FROM gtfs.transfers a
    LEFT JOIN gtfs.stops b on a.feed_index = b.feed_index and a.to_stop_id::text = b.stop_id::text
  WHERE coalesce(stop_lat, stop_lon) IS NULL;

SELECT 'gtfs.transfers_from_route_fkey', count(distinct (a.feed_index, from_route_id))
  FROM gtfs.transfers a
    LEFT JOIN gtfs.routes b on a.feed_index = b.feed_index and a.from_route_id::text = b.route_id::text
  WHERE b.agency_id IS NULL;

SELECT 'gtfs.transfers_to_route_fkey', count(distinct (a.feed_index, to_route_id))
  FROM gtfs.transfers a
    LEFT JOIN gtfs.routes b on a.feed_index = b.feed_index and a.to_route_id::text = b.route_id::text
  WHERE b.agency_id IS NULL;

SELECT 'gtfs.transfers_service_fkey', count(distinct (feed_index, service_id))
  FROM gtfs.transfers a
    LEFT JOIN gtfs.calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

-- Find out-of-order stops for the most recent feed added.
-- Change the first subquery to select different feeds.
WITH
  f AS (SELECT MAX(feed_index) AS feed_index FROM gtfs.feed_info),
  d AS (
    SELECT
      feed_index,
      trip_id,
      stop_id,
      stop_sequence,
      coalesce(lag(shape_dist_traveled) over (trip), 0) AS lag,
      shape_dist_traveled AS dist,
      (lead(shape_dist_traveled) over (trip)) AS lead
    FROM gtfs.stop_times
      INNER JOIN f USING (feed_index)
    WINDOW trip AS (PARTITION BY feed_index, trip_id ORDER BY stop_sequence)
  )
  SELECT feed_index,
    trip_id,
    route_id,
    stop_id,
    stop_sequence,
    lag::numeric(9, 3),
    dist::numeric(9, 3), 
    coalesce(lead, length)::numeric(9, 3) as lead,
    length::numeric(9, 3)
  FROM d
    LEFT JOIN gtfs.trips trip USING (feed_index, trip_id)
    LEFT JOIN gtfs.shape_geoms shape USING (feed_index, shape_id)
  WHERE
      COALESCE(lead, length) > lag
      AND (dist > COALESCE(lead, length) OR dist < lag);
