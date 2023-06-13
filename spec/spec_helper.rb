# frozen_string_literal: true

require 'database_cleaner'

require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH << File.expand_path('support', __dir__)

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', __dir__)
require 'bundler'
Bundler.setup

ENV['RAILS_ENV'] = 'test'

require 'appraisal_helper'

require 'active_model'
# require ActiveRecord to ensure that Ransack loads correctly
require 'active_record'
require 'action_view'

require 'active_admin'

ActiveAdmin.application.load_paths = ["#{ENV['RAILS_ROOT']}/app/admin"]
require "#{ENV['RAILS_ROOT']}/config/environment.rb"

# Disabling authentication in specs so that we don't have to worry about
# it allover the place
ActiveAdmin.application.authentication_method = false
ActiveAdmin.application.current_user_method = false

require 'rspec/rails'
require 'support/admin'
require 'capybara/rails'
require 'capybara/rspec'

unless ENV['CAPYBARA_FIREFOX']
  require 'capybara/poltergeist'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      { js_errors: false,
        timeout: 80,
        debug: false,
        phantomjs_options: ['--debug=no', '--load-images=no'] }
    )
  end

  Capybara.javascript_driver = :poltergeist
end

RSpec.configure do |config|
  DatabaseCleaner.strategy = :truncation

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
