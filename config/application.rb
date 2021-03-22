# frozen_string_literal: true

require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "active_job/railtie"
require "view_component/engine"

require "active_support/core_ext/integer/time"

Bundler.require(*Rails.groups)

module AnycableRailsDemo
  class Application < Rails::Application
    config.load_defaults 6.0

    config.autoload_paths << Rails.root.join("frontend", "components")
    config.view_component.preview_paths << Rails.root.join("frontend", "components")

    config.generators do |g|
      g.assets false
      g.helper false
      g.orm :active_record
      g.stylesheets false
      g.javascripts false
      g.test_framework nil
    end
  end
end
