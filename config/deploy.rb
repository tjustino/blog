# frozen_string_literal: true

require "mina/bundler"
require "mina/deploy"
require "mina/git"
require "mina/rbenv"

set :application_name, "blog"
set :domain,           "justino.fr"
set :deploy_to,        "/srv/http/#{fetch(:application_name)}"
set :repository,       "git@github.com:tjustino/blog.git"
set :branch,           "main"
set :bundle_path,      "vendor/bundle"

# Optional settings:
#   set :user, "foobar"          # Username in the server to SSH to.
#   set :port, "30000"           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the "deploy:link_shared_paths" step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push("public/assets")
set :shared_dirs, fetch(:shared_dirs, []).push("log", "tmp/cache", "tmp/sockets", fetch(:bundle_path))
# set :shared_files, fetch(:shared_files, []).push("config/database.yml", "config/secrets.yml")

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :"rbenv:load"
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.5.3 --skip-existing}
  # command %{rvm install ruby-2.5.3}
  # command %{gem install bundler}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :"git:ensure_pushed"
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :"git:clone"
    invoke :"deploy:link_shared_paths"
    invoke :"bundle:install"
    invoke :"deploy:cleanup"

    on :launch do
      in_path(fetch(:current_path)) do
        # command %{mkdir -p tmp/}
        # command %{touch tmp/restart.txt}
      end
    end
  end

  run(:local) { say "done 🎉" }
end
