module Scrapable
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def scrape_from_external_source!
      load_settings
      return unless  @settings[:enabled]

      prepare_connection
      load_external_list
      scrape_list
      process_list
      save_models
    end

    private

    def load_settings
      @settings ||= Rails.application.config.x.scraping
    end

    def prepare_connection
      @client = Faraday.new url: @settings[:domain] do |f|
        f.params = { expand: 'body.storage' }
        f.headers = { 'Content-Type' => 'application/json' }
        f.request :json
        f.request :authorization, 'Bearer', @settings.access_token.strip
        f.response :json
      end
    end

    def load_external_list
      response = @client.get "rest/api/content/#{@settings.page_content_id}"
      body = (response.body.is_a?(Hash) ? response.body : JSON.parse(response.body)).with_indifferent_access

      @raw_page = body.dig :body, :storage, :value
      logger.warn "fetched content is empty" unless @raw_page
    rescue Faraday::Error, JSON::ParserError => e
      logger.error e
    end

    def scrape_list
      @scraped_list = []
      @document = Nokogiri::HTML @raw_page
      lines = @document.css 'table tbody tr'
      lines.each.with_index do |line, i|
        next if i == 0

        license_name  = line.css 'td:nth-child(1)'
        expiry_date   = line.css 'td:nth-child(10)'
        license_owner = line.css 'td:nth-last-child(2)'

        @scraped_list << {
          title: license_name.text,
          current_expire_date: expiry_date.text,
          owner: license_owner.text
        }
      end
    end

    def process_list
      attr_keys = %i(title current_expire_date owner)

      @scraped_list.each do |l|
        attr_keys.map { |a| l[a]&.squish!&.strip! }
      end

      @scraped_list.reject! do |l|
        attr_keys.any? { |a| l[a].blank? || l[a].upcase == 'N/A' }
      end
    end

    def save_models
      @scraped_list.each { |l| model = License.find_or_create_by! l }
    end
  end
end
