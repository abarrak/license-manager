# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
#
# Learn more: http://github.com/javan/whenever
#
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
#
set :output, "/var/logs/license_manager_cron.log"

every 1.day, at: "1:00 pm" do
  runner "CollectInventoryJob.perform_now"
  runner "RunExpiryChecksJob.set(wait: 5.seconds).perform_now"
end


# run the following  whenever --update-crontab as part of deployment process.
