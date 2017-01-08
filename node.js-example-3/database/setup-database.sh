#!/bin/bash

TEST=`psql -U "$POSTGRES_USER" <<- EOSQL
   SELECT 1 FROM pg_database WHERE datname='$DB_NAME';
EOSQL`

echo "******CREATING DOCKER DATABASE******"
if [[ $TEST == "1" ]]; then
    # database exists
    # $? is 0
    exit 0
else
psql -U "$POSTGRES_USER" <<- EOSQL
   CREATE ROLE $DB_USER WITH LOGIN ENCRYPTED PASSWORD '${DB_PASS}' CREATEDB;
EOSQL

psql -U "$POSTGRES_USER" <<- EOSQL
   CREATE DATABASE $DB_NAME WITH OWNER $DB_USER TEMPLATE template0 ENCODING 'UTF8';
EOSQL

psql -U "$POSTGRES_USER" <<- EOSQL
   GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOSQL

gosu postgres psql --username "$DB_USER" "$DB_NAME" -f /usr/schema.sql
fi

echo ""
echo "******DOCKER DATABASE CREATED******"
