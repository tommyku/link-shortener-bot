FROM ruby:2.3.1-alpine
MAINTAINER tommyku

RUN apk add -U alpine-sdk

COPY Gemfile Gemfile.lock /app/

WORKDIR /app/

RUN gem install json -v '2.0.3'

RUN bundle

COPY . /app/
