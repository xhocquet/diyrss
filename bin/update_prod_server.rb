ENV_VARS = "RAILS_ENV=production RACK_ENV=production RAILS_SERVE_STATIC_FILES=true"
BUNDLE = "/usr/share/rvm/gems/ruby-2.4.1/bin/bundle"

`ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9`
`ps -ef | grep puma | grep -v grep | awk '{print $2}' | xargs kill -9`

`#{BUNDLE} exec rails assets:clobber`
`git pull`

`#{ENV_VARS} #{BUNDLE} install`
`#{ENV_VARS} npm install`
`#{ENV_VARS} #{BUNDLE} exec rails assets:precompile`
`#{ENV_VARS} #{BUNDLE} exec rails db:migrate`

`#{ENV_VARS} whenever --update-crontab`

`#{ENV_VARS} #{BUNDLE} exec puma -C config/puma.rb`
`#{ENV_VARS} #{BUNDLE} exec sidekiq -d -C config/sidekiq.yml`
