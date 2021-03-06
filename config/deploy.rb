# frozen_string_literal: true

set :application, "blog"

# setup repo
set :repo_url, "git@github.com:tjustino/blog.git"

# setup deploy details
set :deploy_user, "tomj"
set :deploy_to,   "/srv/http/#{fetch(:application)}"

# setup ssh
set :ssh_options, forward_agent: true

# setup rbenv
set :rbenv_type,   :user
set :rbenv_ruby,   RUBY_VERSION
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} "    \
                   "RBENV_VERSION=#{fetch(:rbenv_ruby)} " \
                   "#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby puma pumactl]

# files/dirs we want symlinking to shared
set :linked_dirs, %w[ bin
                      log
                      tmp/pids
                      tmp/cache
                      tmp/sockets
                      vendor/bundle
                      public/system ]

# how many old releases do we want to keep
set :keep_releases, 5
