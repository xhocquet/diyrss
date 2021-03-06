ENV_VARS = "RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true"

puts "Stopping Sidekiq and Puma..."
`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`
puts "Sidekiq and Puma stopped"


puts "Starting Puma and Sidekiq..."
`#{ENV_VARS} bundle exec puma -C config/puma.rb`
`#{ENV_VARS} bundle exec sidekiq -d -C config/sidekiq.yml`
puts "Puma and Sidekiq restarted"
