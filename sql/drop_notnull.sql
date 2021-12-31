SET search_path TO :schema;

ALTER TABLE agency  
  ALTER COLUMN agency_name DROP NOT NULL,
  ALTER COLUMN agency_timezone DROP NOT NULL,
  ALTER COLUMN agency_url DROP NOT NULL;

ALTER TABLE attributions  
  ALTER COLUMN organization_name DROP NOT NULL;

ALTER TABLE calendar  
  ALTER COLUMN end_date DROP NOT NULL,
  ALTER COLUMN monday DROP NOT NULL,
  ALTER COLUMN tuesday DROP NOT NULL,
  ALTER COLUMN wednesday DROP NOT NULL,
  ALTER COLUMN thursday DROP NOT NULL,
  ALTER COLUMN friday DROP NOT NULL,
  ALTER COLUMN saturday DROP NOT NULL,
  ALTER COLUMN sunday DROP NOT NULL,
  ALTER COLUMN start_date DROP NOT NULL;

ALTER TABLE fare_attributes  
  ALTER COLUMN currency_type DROP NOT NULL,
  ALTER COLUMN transfers DROP NOT NULL,
  ALTER COLUMN payment_method DROP NOT NULL,
  ALTER COLUMN price DROP NOT NULL;

ALTER TABLE feed_info  
  ALTER COLUMN feed_publisher_name DROP NOT NULL,
  ALTER COLUMN feed_publisher_url DROP NOT NULL,
  ALTER COLUMN feed_lang DROP NOT NULL;

ALTER TABLE frequencies  
  ALTER COLUMN end_time DROP NOT NULL,
  ALTER COLUMN headway_secs DROP NOT NULL;

ALTER TABLE levels  
  ALTER COLUMN level_index DROP NOT NULL;

ALTER TABLE pathways  
  ALTER COLUMN pathway_mode DROP NOT NULL,
  ALTER COLUMN from_stop_id DROP NOT NULL,
  ALTER COLUMN to_stop_id DROP NOT NULL,
  ALTER COLUMN is_bidirectional DROP NOT NULL;

ALTER TABLE routes  
  ALTER COLUMN route_type DROP NOT NULL;

ALTER TABLE shape_geoms  
  ALTER COLUMN length DROP NOT NULL,
  ALTER COLUMN the_geom DROP NOT NULL;

ALTER TABLE shapes  
  ALTER COLUMN shape_pt_lon DROP NOT NULL,
  ALTER COLUMN shape_pt_lat DROP NOT NULL;

ALTER TABLE transfers  
  ALTER COLUMN transfer_type DROP NOT NULL;

ALTER TABLE translations  
  ALTER COLUMN field_name DROP NOT NULL,
  ALTER COLUMN translation DROP NOT NULL;

ALTER TABLE trips  
  ALTER COLUMN route_id DROP NOT NULL,
  ALTER COLUMN service_id DROP NOT NULL;
