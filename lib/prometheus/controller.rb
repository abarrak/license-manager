module Prometheus
  module Controller
    def self.setup_metrics
      @prometheus = Prometheus::Client.registry

      @total ||= begin
        gauge = Prometheus::Client::Gauge.new :total_licenses_count, docstring: 'The total licenses managed.'
        @prometheus.register gauge
      end

      @expired ||= begin
        gauge = Prometheus::Client::Gauge.new :expired_licenses_count, docstring: 'The number of expired licenses count.'
        @prometheus.register gauge
        gauge
      end

      @expiring ||= begin
        gauge = Prometheus::Client::Gauge.new :expiring_licenses_count, docstring: 'The number of expiring soon licenses (< 30 days).'
        @prometheus.register gauge
        gauge
      end
    end
  end
end