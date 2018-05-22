`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`

`git stash`
`git pull`

`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle install`
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true yarn`
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true rails db:migrate`

`git stash pop`

`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle exec puma -C config/puma.rb -p 80 -d`
`RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true bundle exec sidekiq -d -L log/sidekiq.log`
