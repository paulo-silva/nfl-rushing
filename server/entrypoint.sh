#!/bin/bash

DB_USER=${DATABASE_USER:-postgres}

while ! pg_isread -q -h $DATABASE_HOST -p 5432 -U $DB_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

mix ecto.create
mix ecto.migrate
echo "migrated"

# start the elixir application
exec "$bin" "start"
