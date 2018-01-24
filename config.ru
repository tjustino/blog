require "rubygems"
require "bundler"

Bundler.require

require_relative "app/blog.rb"
run Sinatra::Application
