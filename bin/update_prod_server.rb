puts "Stopping Sidekiq and Puma..."
`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`
puts "Sidekiq and Puma stopped"

puts "Stashing production assets"
`git stash`
`git pull`

puts "Updating gems"
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle install`
puts "Updating node modules"
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true yarn`
puts "Migrating database"
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true rails db:migrate`

puts "Restoring stashed production assets"
`git stash pop`

puts "Restarting Puma and Sidekiq..."
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle exec puma -C config/puma.rb -p 80 -d`
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle exec sidekiq -d -L log/sidekiq.log`
puts "Puma and Sidekiq restarted"
