`export RAILS_ENV=production`
`export RACK_ENV=production`
`export RAILS_SERVE_STATIC_FILES=true`

`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`

`git stash`
`git pull`

`bundle install`
`yarn`
`rails db:migrate`

`git stash pop`

`bundle exec puma -C config/puma.rb -p 80 -d`
`bundle exec sidekiq -d -L log/sidekiq.log`
