# frozen_string_literal: true

require "sinatra/base"

# What a minimalist app!
class MyBlog < Sinatra::Base
  get "/" do
    erb :presentation
  end

  ["/kdo", "/cadeau", "/cadeaux"].each do |path|
    get path do
      erb :kdo
    end
  end

  ["/coherence-cardiaque", "/coherence", "/cc"].each do |path|
    get path do
      erb :coherence
    end
  end

  get "/up" do
    "<!DOCTYPE html><html><body style=\"background-color: green\"></body></html>"
  end

  get "/*" do
    redirect "/"
  end
end
