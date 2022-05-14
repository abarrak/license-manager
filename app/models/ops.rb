class Ops
  include ActiveModel::API

  def self.sync_now
    CollectInventoryJob.perform_later
    RunExpiryChecksJob.set(wait: 5.seconds).perform_later
    GenerateCustomMetricsJob.set(wait: 8.seconds).perform_later
  end

  def self.clear_all
    License.destroy_all
  end
end
