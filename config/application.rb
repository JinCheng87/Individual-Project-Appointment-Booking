require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Booking
  class Application < Rails::Application
    config.secret_key_base = ENV["SECRET_KEY_BASE"]
    config.active_job.queue_adapter = :resque
    config.time_zone = 'Central Time (US & Canada)'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
