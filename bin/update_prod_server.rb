ENV_VARS = "RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true"

`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`

`rails assets:clobber`
`git pull`

`#{ENV_VARS} bundle install`
`#{ENV_VARS} npm install`
`#{ENV_VARS} bundle exec rails assets:precompile`
`#{ENV_VARS} bundle exec rails db:migrate`

`#{ENV_VARS} whenever --update-crontab`

`#{ENV_VARS} bundle exec puma -C config/puma.rb`
`#{ENV_VARS} bundle exec sidekiq -d -C config/sidekiq.yml`
