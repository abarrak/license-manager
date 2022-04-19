class RunExpiryChecksJob < ApplicationJob
  queue_as :default

  def perform(*args)
    LicenseExpiry.calculate_all_expiries!
  end
end
