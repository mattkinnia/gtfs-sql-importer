CREATE TRIGGER stop_geom_trigger BEFORE INSERT OR UPDATE ON :schema.stops
  FOR EACH ROW EXECUTE PROCEDURE :schema.stop_geom_update();
