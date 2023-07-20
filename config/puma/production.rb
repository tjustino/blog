# frozen_string_literal: true

root_deploiement = File.expand_path("../../../", File.dirname(__FILE__))

directory "#{root_deploiement}/current"
environment "production"

pidfile "#{root_deploiement}/shared/tmp/pids/puma.pid"
state_path "#{root_deploiement}/shared/tmp/pids/puma.state"
stdout_redirect "#{root_deploiement}/shared/log/puma_access.log", "#{root_deploiement}/shared/log/puma_error.log", true

bind "unix://#{root_deploiement}/shared/tmp/sockets/puma.sock"
