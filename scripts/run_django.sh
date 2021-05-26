#!/bin/bash

DEPLOY_FLAG=./deploy_state.flag

touch $DEPLOY_FLAG

python manage.py migrate
python manage.py collectstatic --no-input

rm -f $DEPLOY_FLAG
echo "Run Django"

python manage.py runserver 0.0.0.0:8000