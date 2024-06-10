# frozen_string_literal: true

require          "rack/protection"
require_relative "app/blog"

use Rack::Protection

run MyBlog
