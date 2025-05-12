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
      # Année scolaire 2025-2026
      # https://www.education.gouv.fr/bo/2024/Hebdo41/MENE2415135A
      # Français      → https://www.education.gouv.fr/sites/default/files/ensel135_annexe3.pdf
      # Mathématiques → https://www.education.gouv.fr/sites/default/files/ensel135_annexe4.pdf

      # https://media.education.gouv.fr/file/02_fevrier/24/3/BOEcolePrimaireWeb_24243.pdf
      @mots_outils = ["à", "alors", "après", "au", "aussi", "aussitôt", "autour", "avant", "avec", "bien", "c'est",
                      "c'était", "car", "ce", "celle", "ces", "cette", "chacun", "chez", "comme", "comment", "dans",
                      "de", "debout", "dedans", "derrière", "des", "devant", "dont", "du", "déjà", "elle", "elles",
                      "en", "encore", "ensuite", "entre", "est", "et", "ici", "il", "il fait", "il y a", "ils", "j'ai",
                      "je", "l'", "la", "le", "les", "ma", "mais", "mes", "moins", "mon", "même", "ne … jamais",
                      "ne … pas", "ne … plus", "non", "nous", "on", "ou", "oui", "où", "par", "peut-être", "plus",
                      "pour", "près", "près de", "puis", "quand", "que", "quel", "quelle", "qui", "quoi", "sa", "sans",
                      "ses", "si", "son", "soudain", "sous", "sur", "ta", "tard", "tes", "ton", "toujours", "tout",
                      "trop", "très", "tu", "tôt", "un", "une", "vers", "voici", "voilà", "vous", "y"].sample(8)

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
