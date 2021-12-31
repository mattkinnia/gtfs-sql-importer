SET search_path TO :schema;

ALTER TABLE agency  
  ALTER COLUMN agency_name SET NOT NULL,
  ALTER COLUMN agency_timezone SET NOT NULL,
  ALTER COLUMN agency_url SET NOT NULL;

ALTER TABLE attributions  
  ALTER COLUMN organization_name SET NOT NULL;

ALTER TABLE calendar  
  ALTER COLUMN end_date SET NOT NULL,
  ALTER COLUMN service_id SET NOT NULL,
  ALTER COLUMN monday SET NOT NULL,
  ALTER COLUMN tuesday SET NOT NULL,
  ALTER COLUMN wednesday SET NOT NULL,
  ALTER COLUMN thursday SET NOT NULL,
  ALTER COLUMN friday SET NOT NULL,
  ALTER COLUMN saturday SET NOT NULL,
  ALTER COLUMN sunday SET NOT NULL,
  ALTER COLUMN start_date SET NOT NULL;

ALTER TABLE fare_attributes  
  ALTER COLUMN currency_type SET NOT NULL,
  ALTER COLUMN transfers SET NOT NULL,
  ALTER COLUMN payment_method SET NOT NULL,
  ALTER COLUMN price SET NOT NULL,
  ALTER COLUMN fare_id SET NOT NULL;

ALTER TABLE feed_info  
  ALTER COLUMN feed_publisher_name SET NOT NULL,
  ALTER COLUMN feed_publisher_url SET NOT NULL,
  ALTER COLUMN feed_lang SET NOT NULL;

ALTER TABLE frequencies  
  ALTER COLUMN trip_id SET NOT NULL,
  ALTER COLUMN start_time SET NOT NULL,
  ALTER COLUMN end_time SET NOT NULL,
  ALTER COLUMN headway_secs SET NOT NULL;

ALTER TABLE levels  
  ALTER COLUMN level_index SET NOT NULL,
  ALTER COLUMN level_id SET NOT NULL;

ALTER TABLE pathways  
  ALTER COLUMN pathway_mode SET NOT NULL,
  ALTER COLUMN pathway_id SET NOT NULL,
  ALTER COLUMN from_stop_id SET NOT NULL,
  ALTER COLUMN to_stop_id SET NOT NULL,
  ALTER COLUMN is_bidirectional SET NOT NULL;

ALTER TABLE routes  
  ALTER COLUMN route_type SET NOT NULL;

ALTER TABLE shape_geoms  
  ALTER COLUMN length SET NOT NULL,
  ALTER COLUMN the_geom SET NOT NULL;

ALTER TABLE shapes  
  ALTER COLUMN shape_pt_lon SET NOT NULL,
  ALTER COLUMN shape_pt_lat SET NOT NULL;

ALTER TABLE transfers  
  ALTER COLUMN transfer_type SET NOT NULL;

ALTER TABLE translations  
  ALTER COLUMN field_name SET NOT NULL,
  ALTER COLUMN translation SET NOT NULL,
  ALTER COLUMN field_value SET NOT NULL;;

ALTER TABLE trips  
  ALTER COLUMN route_id SET NOT NULL,
  ALTER COLUMN service_id SET NOT NULL;
