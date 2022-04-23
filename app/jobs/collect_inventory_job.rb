class CollectInventoryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    License.scrape_from_external_source!
  end
end
