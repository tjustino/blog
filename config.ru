# frozen_string_literal: true

require "rubygems"
require "bundler"

Bundler.require

require_relative "app/blog"
run Sinatra::Application
