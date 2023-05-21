FROM ruby:3.2.2-alpine3.18

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
