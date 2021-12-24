# frozen_string_literal: true

set :application, "blog"
set :repo_url,    "git@github.com:tjustino/blog.git"
set :deploy_to,   "/srv/http/#{fetch(:application)}"

# files/dirs we want symlinking to shared
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"

# setup rbenv
set :rbenv_type,   :user
set :rbenv_ruby,   RUBY_VERSION
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} "    \
                   "RBENV_VERSION=#{fetch(:rbenv_ruby)} " \
                   "#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby puma pumactl]

# how many old releases do we want to keep
set :keep_releases, 5
