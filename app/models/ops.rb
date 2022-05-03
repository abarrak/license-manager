class Ops
  include ActiveModel::API

  def self.sync_now
    CollectInventoryJob.perform_now
    RunExpiryChecksJob.set(wait: 5.seconds).perform_now
    GenerateCustomMetricsJob.set(wait: 8.seconds).perform_now
  end

  def self.clear_all
    License.destroy_all
  end
end
