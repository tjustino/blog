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

  ["/mots-outils", "/mots", "/mo"].each do |path|
    get path do
      @set1 = ["un", "le", "il y a ", "sur", "dans", "la", "et", "sous", "est",
               "une", "il", "aussi", "des", "c'est", "elle", "les", "du"].sample
      @set2 = ["avec", "ses", "j'ai", "même", "mon", "pour", "de", "mes", "près de", "mais",
               "car", "son", "comme", "non", "il fait", "autour", "puis", "déjà", "chez"].sample
      @set3 = %w[quand tes cette aussitôt mais toujours qui
                 debout ensuite devant derrière après voici celle].sample
      @set4 = ["voilà", "encore", "alors", "soudain", "c'était", "vers",
               "peut-être", "dedans", "tout", "quel", "chacun"].sample
      erb :mots
    end
  end

  get "/up" do
    "<!DOCTYPE html><html><body style=\"background-color: green\"></body></html>"
  end

  get "/*" do
    redirect "/"
  end
end
