#!/bin/bash
export PGPASSWORD=$PGADMINPW

until psql -h $PGHOST -d postgres -U $PGADMIN -p $PGPORT -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
