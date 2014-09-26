set :stage,     :production
set :branch,    "master"

set :server_name, "thomas.justino.fr"
set :enable_ssl,  false

server "thomas.justino.fr", user: "tomj", roles: %w{web app}, primary: true
