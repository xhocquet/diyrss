exec "ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9"
exec "ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9"

exec "git stash"
exec "git pull"
exec "git stash pop"

exec "RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle exec puma -C config/puma.rb -p 80 -d"
exec "RAILS_ENV=production RACK_ENV=production bundle exec sidekiq -d -L log/sidekiq.log"
