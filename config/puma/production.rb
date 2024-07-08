# frozen_string_literal: true

directory "/home/tomj/www/blog/current"
environment "production"

pidfile "/home/tomj/www/blog/shared/tmp/pids/puma.pid"
state_path "/home/tomj/www/blog/shared/tmp/pids/puma.state"
stdout_redirect "/home/tomj/www/blog/shared/log/puma_access.log", "/home/tomj/www/blog/shared/log/puma_error.log", true

bind "unix:///home/tomj/www/blog/shared/tmp/sockets/puma.sock"
