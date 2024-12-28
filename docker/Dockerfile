###############################################################################
FROM nginx:1.27.3-alpine AS nginx

WORKDIR /app/public

ADD docker/nginx/rails-vhost.conf /etc/nginx/conf.d/default.conf

###############################################################################
FROM ruby:3.4.1-alpine AS ruby-base

RUN apk --no-cache add imagemagick tzdata nodejs libpq

###############################################################################
FROM ruby-base AS ruby-build

RUN apk --no-cache add build-base libpq-dev

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

# Run and own only the runtime files as a non-root user for security
RUN adduser rails -D && \
    chown -R rails:rails db log storage tmp
USER rails:rails

ENV APP_ENV production
ENV RACK_ENV production

# Entrypoint prepares the database
ENTRYPOINT ["/app/bin/docker-entrypoint"]

CMD ["./bin/rails", "server"]

###############################################################################
FROM nginx AS web-production

COPY --from=ruby-build /app/public /app/public
