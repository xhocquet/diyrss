ENV_VARS = "RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true"

puts "Stopping Sidekiq and Puma..."
`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`

puts "Restarting Puma and Sidekiq..."
`#{ENV_VARS} bundle exec sidekiq -q default -q mailers -d -L log/sidekiq.log`
