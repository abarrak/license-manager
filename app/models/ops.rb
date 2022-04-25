class Ops
  include ActiveModel::API

  def self.sync_now
    CollectInventoryJob.perform_now
    RunExpiryChecksJob.set(wait: 5.seconds).perform_later
    GenerateCustomMetricsJob.set(wait: 7.seconds).perform_later
  end

  def self.clear_all
    License.destroy_all
  end
end
