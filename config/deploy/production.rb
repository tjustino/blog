set :stage,     :production
set :branch,    "master"

set :server_name, "www.justino.fr justino.fr"
set :enable_ssl,  false

server "justino.fr", user: "tomj", roles: %w{web app}, primary: true
