ENV_VARS = "RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true"

puts "Stopping Sidekiq and Puma..."
`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`
puts "Sidekiq and Puma stopped"

puts "Clearing production assets"
`rails assets:clobber`
`git pull`

puts "Updating gems"
`#{ENV_VARS} bundle install`
puts "Updating modules"
`#{ENV_VARS} npm install`
puts "Updating node modules and compiling assets"
`#{ENV_VARS} bundle exec rails assets:precompile`
puts "Migrating database"
`#{ENV_VARS} bundle exec rails db:migrate`

puts "Updating CRON tab"
`#{ENV_VARS} whenever --update-crontab`

puts "Restarting Puma and Sidekiq..."
`#{ENV_VARS} bundle exec puma -C config/puma.rb`
`#{ENV_VARS} bundle exec sidekiq -d -C config/sidekiq.yml`
puts "Puma and Sidekiq restarted"
