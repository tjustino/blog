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
set :forward_agent,    true
set :bundle_options,   -> { "" }
set :keep_releases,    3

set :shared_dirs, fetch(:shared_dirs, []).push("log", "tmp/pids", "tmp/sockets", fetch(:bundle_path))

task :remote_environment do
  invoke :"rbenv:load"
  command "#{fetch(:bundle_bin)} config set deployment 'true'"
  command "#{fetch(:bundle_bin)} config set path '#{fetch(:bundle_path)}'"
  command "#{fetch(:bundle_bin)} config set without '#{fetch(:bundle_withouts)}'"
end

task :setup do
  command "rbenv install #{RUBY_VERSION} --skip-existing"
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  invoke :"git:ensure_pushed"
  deploy do
    # Put things that will set up an empty directory into a fully set-up instance of your project.
    invoke :"git:clone"
    invoke :"deploy:link_shared_paths"
    invoke :"bundle:install"
    invoke :"deploy:cleanup"

    on :launch do
      # command "systemctl restart puma"
    end
  end
end
