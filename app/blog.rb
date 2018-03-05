require "sinatra"

configure do
  set :root,  File.expand_path("../", __dir__)
  set :views, settings.root + "/app/views"
end

get "/" do
  slim :index, locals: { content: :presentation }
end

["/kdo", "/cadeau", "/cadeaux"].each do |path|
  get path do
    slim :index, locals: { content: :kdo }
  end
end

get "/*" do
  redirect "/"
end
