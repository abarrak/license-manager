#!/bin/bash
set -e
export RAILS_ENV=production

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid
rm -fr /app/log/*.log
touch /app/log/cron.log

service cron start
bundle exec whenever --update-crontab

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
