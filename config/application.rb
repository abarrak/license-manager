require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require "prometheus/client/data_stores/direct_file_store"

module LicenseManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.eager_load_paths << Rails.root.join("lib")

    config.time_zone = "Riyadh"

    unless Rails.env.test?
      logger = ActiveSupport::Logger.new(STDOUT)
      logger.formatter = config.log_formatter
      config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
    end

    config.active_job.queue_adapter = :sucker_punch

    config.after_initialize do
      Prometheus::Controller.setup_metrics
    end
  end
end
