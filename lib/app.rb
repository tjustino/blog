require "sinatra"

set :root, File.expand_path('../../', __FILE__)

get "/" do
  slim :index, locals: { pitch: :main }
end

["/kdo", "/cadeau", "/cadeaux"].each do |path|
  get path do
    slim :index, locals: { pitch: :kdo }
  end
end

get "/*" do
  redirect "/"
end
