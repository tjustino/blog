# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t blog .
# docker run -d -p 80:80 --name blog blog

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.3.6
FROM ruby:$RUBY_VERSION-alpine AS base

# The app lives here
WORKDIR /srv/blog

# Set production environnement
ENV APP_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base AS build
RUN apk add --no-cache build-base
COPY Gemfile Gemfile.lock ./
COPY . .
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Reducing image size
FROM base
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /srv/blog /srv/blog

# Launch the app
EXPOSE 3000
ENTRYPOINT ["bundle", "exec", "puma"]
