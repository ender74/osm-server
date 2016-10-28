CREATE EXTENSION postgis;

CREATE EXTENSION pgrouting;

CREATE EXTENSION hstore;

ALTER TABLE geometry_columns OWNER TO osm;
ALTER TABLE spatial_ref_sys OWNER TO osm;
