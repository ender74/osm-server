ALTER SYSTEM SET shared_buffers='16GB';

-- User: osm
CREATE ROLE osm LOGIN PASSWORD 'osm'
  CREATEDB
   VALID UNTIL 'infinity';
COMMENT ON ROLE osm
  IS 'OSM database user';

-- Database: gis

DROP DATABASE gis;

CREATE DATABASE gis
  WITH OWNER = osm
       ENCODING = 'UTF8'
       TEMPLATE = 'template0'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;

COMMENT ON DATABASE gis
  IS 'Open Street Map Mirror';
