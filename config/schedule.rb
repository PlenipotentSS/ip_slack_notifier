# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every 1.day do
  command "ruby -r '#{Dir.pwd}/services/check_ip.rb' -e 'CheckIp.run'"
end

# Learn more: http://github.com/javan/whenever
