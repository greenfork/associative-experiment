# Require this file for feature tests
require_relative './spec_helper'

require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.timeout = 5
  config.ignore_ssl_errors
  config.skip_image_loading
  config.raise_javascript_errors = true
end

Capybara.app = Hanami.app

class MiniTest::Spec
  include Capybara::DSL
end
