class GenerateCustomMetricsJob < ApplicationJob
  include Prometheus::Controller

  queue_as :default

  RECORD_NAMES_COLLECTOR = lambda do |rs|
    rs&.to_a.map { |r| r.respond_to?(:title) ? r.title : r.license.title }.join(' - ')
  end

  def perform(*args)
    Prometheus::Controller.clear_metrics
    Prometheus::Controller.setup_metrics

    prometheus = Prometheus::Client.registry

    total_gauge    = prometheus.get :total_licenses_count
    expired_gauge  = prometheus.get :expired_licenses_count
    expiring_gauge = prometheus.get :expiring_licenses_count

    total = License.all
    total_names = RECORD_NAMES_COLLECTOR.[] total
    total_gauge.set total.count, labels: { names: total_names }

    expired = LicenseExpiry.includes(:license).where(days_count: 0)
    expired_names = RECORD_NAMES_COLLECTOR.[] expired
    expired_count = expired.count
    expired_gauge.set expired_count, labels: { names: expired_names }

    expiring = LicenseExpiry.includes(:license).where('days_count < 30 AND days_count != 0')
    expiring_names = RECORD_NAMES_COLLECTOR.[] expiring
    expiring_count = expiring.count
    expiring_gauge.set expiring_count, labels: { names: expiring_names }
  end
end
