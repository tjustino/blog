# frozen_string_literal: true

# This configuration file will be evaluated by Puma
# The top-level methods that are invoked here are part of Puma's configuration DSL
# For more information about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html

workers 3
port = ENV["APP_ENV"] == "production" ? 80 : 3000
bind "tcp://0.0.0.0:#{port}"
