#!/bin/bash

bash -c "bundle exec sidekiq" &

bash -c "rails db:create && rails db:migrate && bundle exec rails s -p 3200 -b '0.0.0.0'" -D

status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit 1
fi