#!/bin/bash

# Waiting for Django
sleep 5

while [ -f /opt/chat/deploy_state.flag ];
do
    sleep 1;
    echo "Wait for django"
done;

python -m celery -A config worker -l info