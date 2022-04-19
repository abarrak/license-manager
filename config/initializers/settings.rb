Rails.configuration.x.email.sender  = "sre@example.com"
Rails.configuration.x.exmil.main_cc = "sre@example.com"

Rails.configuration.x.scraping.enabled = ENV["SCRAPE_EXTERNAL_SOURCE"] || true
Rails.configuration.x.scraping.assets_page_url = ENV["TARGET_ASSETS_WEB_PAGE"] || ''