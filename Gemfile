source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'devise'
gem 'sass-rails', '~> 5.0'

# Errors
gem 'rollbar'

# JS
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "recaptcha", require: "recaptcha/rails"

# Web scraping
gem 'mechanize'
gem 'loofah'

# Workers
gem 'sidekiq'

# Admin
gem 'administrate', git: 'https://github.com/thoughtbot/administrate.git', branch: 'master', ref: 'b85abcf965ecc843ee9b25e3a2ea65dfeb1b0b3c'

# Nice diffs
gem 'diffy'

# Email styling
gem 'premailer-rails'

gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem "letter_opener"
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
