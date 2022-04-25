class GenerateCustomMetricsJob < ApplicationJob
  include Prometheus::Controller

  queue_as :default

  def perform(*args)
    Prometheus::Controller.clear_metrics
    Prometheus::Controller.setup_metrics

    prometheus = Prometheus::Client.registry

    total_gauge    = prometheus.get :total_licenses_count
    expired_gauge  = prometheus.get :expired_licenses_count
    expiring_gauge = prometheus.get :expiring_licenses_count

    total = License.count
    total_gauge.set total, labels: { hint: "the total assets maanged." }
    record_names_collector = lambda { |rs| rs&.to_a.map { |r| r.license.title }.join(' - ') }

    expired = LicenseExpiry.includes(:license).where(days_count: 0)
    expired_names = record_names_collector.[] expired
    expired_count = expired.count
    expired_gauge.set expired_count, labels: { names: expired_names }

    expiring = LicenseExpiry.includes(:license).where('days_count < 30 AND days_count != 0')
    expiring_names = record_names_collector.[] expiring
    expiring_count = expiring.count
    expiring_gauge.set expiring_count, labels: { names: expiring_names }
  end
end
