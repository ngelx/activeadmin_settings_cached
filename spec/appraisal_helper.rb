# load the right dummy app.
require 'rails'

ENV['RAILS'] = Rails.version
puts "Using Rails #{Rails.version}"
ENV['RAILS_ROOT'] = File.expand_path("../rails/rails-#{ENV['RAILS']}", __FILE__)
# Create the test app if it doesn't exists
puts "using bundlefrom : #{ENV['BUNDLE_GEMFILE']}"
appraisal_env = "rails#{Rails::VERSION::STRING.split('.').first(2).join('.')}"

if File.exist?(ENV['RAILS_ROOT'])
  puts "Using dummy Rails in #{ENV['RAILS_ROOT']}"
else
  dir = "spec/rails/rails-#{Rails::VERSION::STRING}"

  if File.exist?(dir)
    puts "test app #{dir} already exists; skipping"
  else
    puts "Creating testing app in #{dir}."
    system 'mkdir -p spec/rails'

    args = %w[
      -m\ spec/support/rails_template.rb
      --skip-gemfile
      --skip-bundle
      --skip-git
      --skip-turbolinks
      --skip-test-unit
      --skip-spring
    ]

    system "appraisal #{appraisal_env} rails new #{dir} #{args.join ' '}"
  end
end
