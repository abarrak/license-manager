# syntax=docker/dockerfile:1
FROM ruby:2.7.3 AS base

FROM base AS dependencies
RUN apt-get update -qq && apt-get install -y nodejs
RUN apt-get install -y cron

FROM dependencies as build
USER root
WORKDIR /app
COPY . .
RUN gem install bundler
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
