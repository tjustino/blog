require "sinatra"
require "rdiscount"

set :root, File.expand_path('../../', __FILE__)

get "/" do
  file = File.read("#{settings.root}/views/pitch.md")
  pitch = RDiscount.new(file)

  erb :index, locals: { pitch: pitch.to_html }
end

# get "/phrases-qui-marquent" do
#   slim :phrases_qui_marquent
# end

get "/*" do
  redirect "/"
end
