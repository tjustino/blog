# frozen_string_literal: true

require "sinatra/base"

# What a minimalist app!
class MyBlog < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
  end

  get "/" do
    erb :presentation
  end

  ["/kdo", "/cadeau", "/cadeaux"].each do |path|
    get path do
      erb :kdo
    end
  end

  get "/*" do
    redirect "/"
  end
end
