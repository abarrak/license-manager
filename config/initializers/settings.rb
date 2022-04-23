Rails.configuration.x.email.sender  = "sre@example.com"
Rails.configuration.x.exmil.main_cc = "sre@example.com"

Rails.configuration.x.scraping.enabled = ENV["SCRAPE_EXTERNAL_SOURCE"] || false
Rails.configuration.x.scraping.domain = ENV["SCRAPE_DOMAIN"]
Rails.configuration.x.scraping.access_email = ENV["SCRAPE_ACCESS_EMAIL"]
Rails.configuration.x.scraping.access_token = ENV["SCRAPE_ACCESS_TOKEN"]
Rails.configuration.x.scraping.page_content_id = ENV["SCRAPE_ASSETS_WEB_PAGE_ID"]
