# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "kamal", require: false     # Deploy web apps in containers to servers running Docker with zero downtime
gem "puma"                      # Ruby/Rack web server built for parallelism
gem "sinatra"                   # Classy web-development dressed in a DSL

group :development do
  gem "foreman"                 # Process manager for applications with multiple components
  gem "rubocop"                 # Automatic Ruby code style checking tool
end
