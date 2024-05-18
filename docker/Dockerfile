###############################################################################
FROM nginx:1.25.4-alpine AS nginx

WORKDIR /app/public

ADD docker/nginx/rails-vhost.conf /etc/nginx/conf.d/default.conf

###############################################################################
FROM ruby:3.3.1-alpine3.18 AS ruby-base

RUN apk --no-cache add imagemagick tzdata nodejs

###############################################################################
FROM ruby-base AS ruby-build

RUN apk --no-cache add build-base

ENV RAILS_ENV="production"

WORKDIR /app
COPY ./ /app
RUN bundle install --deployment --without test development
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

###############################################################################
FROM ruby-base AS ruby-app

ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_ENV="production"

COPY --from=ruby-build /app /app
COPY --from=ruby-build /usr/local/bundle /usr/local/bundle

WORKDIR /app
ENV APP_ENV production
ENV RACK_ENV production
CMD ["./bin/rails", "server"]

###############################################################################
FROM nginx AS web-production

COPY --from=ruby-build /app/public /app/public
