# https://help.github.com/articles/deploying-with-capistrano
require "bundler/capistrano"

# rbenv
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :application, "blog"
set :domain, "justino.fr"
set :deploy_to, "$HOME/www/#{application}"

set :user, "tomj"
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:tjustino/blog.git"
set :branch, "master"
set :deploy_via, :remote_cache

default_run_options[:pty] = true # Must be set for the password prompt from git to work
set :ssh_options, { :forward_agent => true } # Agent Forwarding
ssh_options[:keys] = %w('~/.ssh/id_dsa.pub')

role :app, domain
role :web, domain

# variables
set :deploy_to, "/home/tomj/www/#{application}"
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :rack_env, :production

# Unicorn control tasks
namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rack_env} -D; fi"
  end

  task :start do
    run "cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rack_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end