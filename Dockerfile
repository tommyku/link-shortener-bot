FROM ruby:2.3.1-alpine
MAINTAINER tommyku

RUN apk add -U alpine-sdk

COPY Gemfile Gemfile.lock /app/

WORKDIR /app/

RUN bundle

COPY . /app/
