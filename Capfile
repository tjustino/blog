# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile :
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/bundler
#   https://github.com/seuros/capistrano-puma
#
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/puma'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
