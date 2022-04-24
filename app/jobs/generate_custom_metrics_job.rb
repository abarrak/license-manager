class GenerateCustomMetricsJob < ApplicationJob
  include Prometheus::Controller

  queue_as :default

  def perform(*args)
    prometheus = Prometheus::Client.registry

    total_gauge    = prometheus.get :total_licenses_count
    expired_gauge  = prometheus.get :expired_licenses_count
    expiring_gauge = prometheus.get :expiring_licenses_count

    total_gauge.set License.count
    expired_gauge.set LicenseExpiry.where(days_count: 0).count
    expiring_gauge.set LicenseExpiry.where('days_count < 30').count
  end
end
