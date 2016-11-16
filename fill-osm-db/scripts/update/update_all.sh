#!/bin/bash
for f in $OSM_REGIONS
do
  UPDATE_DIR="${DATA_DIR}${f}"

  if [ -d $UPDATE_DIR ]; then
    cd $UPDATE_DIR
    ./load_next.sh
  else
    echo "update directory not found for $f"
  fi
done
