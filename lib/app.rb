require "sinatra"
require "rdiscount"

set :root, File.expand_path('../../', __FILE__)

def read_markdown(file)
  markdown = File.read("#{settings.root}/views/#{file}")
  pitch = RDiscount.new(markdown)

  pitch.to_html
end

get "/" do
  erb :index, locals: { pitch: read_markdown("root.md") }
end

["/kdo", "/cadeau", "/cadeaux"].each do |path|
  get path do
    erb :index, locals: { pitch: read_markdown("kdo.md") }
  end
end

get "/*" do
  redirect "/"
end
