/**
Insert geometries into shape_geoms by summarizing the shapes table
Arguments
---------
:schema: database schema, typically `gtfs`
:feed_file: the feed zip file, should be a unique row in :schema.feed_info
*/
INSERT INTO :schema.shape_geoms (feed_index, shape_id, length, the_geom)
SELECT feed_index, shape_id, ST_Length(the_geom::geography), the_geom
FROM (
  SELECT
    feed_index,
    shape_id,
    ST_SetSRID(ST_MakeLine(ST_MakePoint(shape_pt_lon, shape_pt_lat) ORDER BY shape_pt_sequence), 4326) AS the_geom
  FROM :schema.shapes s
    JOIN :schema.feed_info USING (feed_index)
  WHERE feed_file = :'feed_file'
  GROUP BY 1, 2
) a;
