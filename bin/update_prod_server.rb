x = `ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
x = `ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`

x = `git stash`
x = `git pull`
x = `git stash pop`

x = `RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle exec puma -C config/puma.rb -p 80 -d`
x = `RAILS_ENV=production RACK_ENV=production bundle exec sidekiq -d -L log/sidekiq.log`
