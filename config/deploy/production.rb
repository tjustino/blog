# frozen_string_literal: true

set :stage,  :production
set :branch, "master"

set :server_name, "thomas.justino.fr"

server "justino.fr", user: "tomj", roles: %w[web app]
