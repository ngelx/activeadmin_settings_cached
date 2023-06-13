# frozen_string_literal: true

require 'bundler'
require 'rake'
require 'rails'

Bundler.setup
Bundler::GemHelper.install_tasks

# Import all our rake tasks
FileList['tasks/**/*.rake'].each { |task| import task }

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts = %w[]
  t.verbose = false
end

desc 'Default: run the rspec examples'
task :default => [:spec]

require File.expand_path("../spec/rails/rails-#{Rails.version}/config/application", __FILE__)

Rails.application.load_tasks
