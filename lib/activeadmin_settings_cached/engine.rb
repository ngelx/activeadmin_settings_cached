# frozen_string_literal: true

require 'rails-settings-cached'
require 'active_admin'

module ActiveadminSettingsCached
  class Engine < Rails::Engine
    config.mount_at = '/'
    config.autoload_paths += Dir["#{config.root}/lib"]

    initializer 'activeadmin_settings_cached' do
      ::ActiveAdmin::DSL.include(::ActiveadminSettingsCached::DSL)
    end
  end
end
