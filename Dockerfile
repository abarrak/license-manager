# syntax=docker/dockerfile:1
FROM ruby:2.7.3 AS base

FROM base AS dependencies
RUN apt-get update -qq && apt-get install -y nodejs
RUN apt-get install -y cron
RUN service cron start

FROM dependencies AS build
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle update --bundler
RUN bundle install

FROM build as runtime
COPY . .
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
