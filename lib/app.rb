require "sinatra"
require "slim"

set :root, File.expand_path('../../', __FILE__)

get "/" do
  slim :index
end

get "/phrases-qui-marquent" do
  slim :phrases_qui_marquent
end

get "/*" do
  redirect "/"
end
