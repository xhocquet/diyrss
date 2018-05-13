# Base and install
FROM ruby:2.3.3
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && apt-get install -y apt-utils build-essential libpq-dev postgresql-client --fix-missing --no-install-recommends
RUN apt-get install -y nodejs build-essential
RUN npm install -g yarn

# Work folder
RUN mkdir /diyrss
WORKDIR /diyrss

# Gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

ENV BUNDLE_GEMFILE=Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle \
    REDIS_URL=redis://redis_db:6379 \
    RAILS_ENV=production \
    RACK_ENV=production

RUN yarn
RUN bundle install
RUN bundle exec rails db:create
RUN bundle exec rails db:migrate

COPY . /diyrss
VOLUME /diyrss/public

RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
