require "test_helper"

class LicenseTest < ActiveSupport::TestCase
  def setup
    enable_scrape_settings
    stub_scrape_api_request
  end

  test "verifiy scraping is functioning and adds licenses list from external source" do
    assert_difference "License.count", 20 do
      License.scrape_from_external_source!
    end
  end

  private

  def enable_scrape_settings
    Rails.configuration.x.scraping.enabled = true
    Rails.configuration.x.scraping.domain = "https://example.com"
    Rails.configuration.x.scraping.access_email = "admin@example.com"
    Rails.configuration.x.scraping.access_token = "tY32mxM91"
    Rails.configuration.x.scraping.page_content_id = 118
  end

  def stub_scrape_api_request
    files_path = '/fixtures/files/'
    json_file_path = File.join File.dirname(__FILE__), '../fixtures/files', 'stubbed_external_source.json'
    html_file_path = File.join File.dirname(__FILE__), '../fixtures/files', 'stubbed_inventory.html'

    html_content = File.read html_file_path
    json_content = File.read json_file_path
    json_content.sub! '<REPLACE_BY_HTML>', html_content.strip

    stub_request(
      :any, -> (uri) { uri.to_s.starts_with? "https://example.com" }
    ).to_return status: 200, body: json_content
  end
end
