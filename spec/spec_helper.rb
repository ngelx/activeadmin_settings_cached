# frozen_string_literal: true

require 'database_cleaner'

require 'coveralls'
Coveralls.wear!

ENV['RAILS_ENV'] = 'test'

require 'appraisal_helper'

require File.expand_path("#{ENV['RAILS_ROOT']}/config/environment", __FILE__)

# require "#{ENV['RAILS_ROOT']}/config/environment.rb"

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
