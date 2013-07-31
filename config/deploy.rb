require "bundler/capistrano"

set :application, "blog"
set :repository,  "git@github.com:tjustino/blog.git"

set :scm, :git

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :use_sudo, false

default_run_options[:pty] = true

set :user, "tomj"
set :group, user
set :runner, user

set :host, "#{user}@justino.fr"
role :web, host
role :app, host

set :rack_env, :production

set :deploy_to, "/home/tomj/www/#{application}"
set :unicorn_conf, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

set :public_children, ["stylesheets","images"]

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