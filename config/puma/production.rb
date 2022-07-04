# frozen_string_literal: true

directory "/srv/http/blog/current"
environment "production"

pidfile "/srv/http/blog/shared/tmp/pids/puma.pid"
state_path "/srv/http/blog/shared/tmp/pids/puma.state"
stdout_redirect "/srv/http/blog/shared/log/puma_access.log", "/srv/http/blog/shared/log/puma_error.log", true

bind "unix:///srv/http/blog/shared/tmp/sockets/puma.sock"
