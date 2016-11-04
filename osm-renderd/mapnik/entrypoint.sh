#!/bin/bash
if [ ! -d /opt/mapnik/data ]
then
  echo "fetching data files ..."
  ./get-shapefiles.sh
else
  echo "data files found."
fi

./waitForPostgres.sh

/usr/bin/renderd -f -c /etc/renderd/renderd.conf
