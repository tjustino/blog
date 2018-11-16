# frozen_string_literal: true

require "sinatra"

configure do
  set :root,   File.dirname(__FILE__)
  set :server, :puma
end

get "/" do
  slim :presentation
end

["/kdo", "/cadeau", "/cadeaux"].each do |path|
  get path do
    slim :kdo
  end
end

get "/*" do
  redirect "/"
end
