#!/bin/bash

### WAITING POSTGRES START ###
RETRIES=7
while [ "$RETRIES" -gt 0 ]
do
  echo "Waiting for postgres server, $((RETRIES--)) remaining attempts..."
  PG_STATUS="$(pg_isready -h chat_db -p 5432)"
  PG_EXIT=$(echo $?)
  echo "Postgres Status: $PG_EXIT - $PG_STATUS"
  if [ "$PG_EXIT" = "0" ];
    then
      RETRIES=0
  fi
  sleep 5  # timeout for new loop
done

### DJANGO MANAGE COMMANDS ###
DEPLOY_FLAG=./deploy_state.flag

touch $DEPLOY_FLAG

python manage.py migrate
python manage.py collectstatic --no-input

rm -f $DEPLOY_FLAG
echo "Run Django"

python manage.py runserver 0.0.0.0:8000