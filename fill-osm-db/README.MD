This project provides some scripts to fetch OSM data and populate an postgresql database with it. The folder `scripts` contains the following files:

`init/setup.sh`

This script prepares the postgresql server. A new database gis with a new user osm / password osm is created. The extensions postgis, pgrouting and hstore are enabled in the gis database. For details have a look into the two sqlscripts prepare_system.sql and prepare_database.sql.

`init/refreshData.sh`

This script loads the configured regions from the geofabrik server. If new data was found, this data will be imported into the gis database (with osm2pgsql). The import is done with the script filldb.sh.

`init/setupAndFillDb.sh`

Combines both steps (setup & refreshData). Does nothing, if the gis database already exists.
