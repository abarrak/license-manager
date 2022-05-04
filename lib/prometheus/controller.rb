module Prometheus
  module Controller
    def self.setup_metrics
      metrics_dir = Rails.root.join 'tmp', 'prometheus'
      Dir["#{metrics_dir}/*.bin"].each { |file_path| File.unlink(file_path) }
      Prometheus::Client.config.data_store = Prometheus::Client::DataStores::DirectFileStore.new(dir: metrics_dir)

      @prometheus ||= Prometheus::Client.registry

      register_gauge :total_licenses_count, 'The total licenses managed.', :names
      register_gauge :expired_licenses_count, 'The number of expired licenses count.', :names
      register_gauge :expiring_licenses_count, 'The number of expiring soon licenses (< 30 days).', :names

    end

    def self.clear_metrics
      @prometheus ||= Prometheus::Client.registry
      unregister_gauge :total_licenses_count
      unregister_gauge :expired_licenses_count
      unregister_gauge :expiring_licenses_count
    end

    def self.register_gauge key, docstring, *labels
      gauge = Prometheus::Client::Gauge.new key, docstring: docstring, labels: labels
      @prometheus.register(gauge)
      gauge
    end

    def self.unregister_gauge key
      @prometheus.unregister key
    end
  end
end
