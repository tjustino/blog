# frozen_string_literal: true

set :stage,  :production
set :branch, "master"

server "justino.fr", ssh_options: { forward_agent: true, user: fetch(:user) }, roles: %w[app web]
