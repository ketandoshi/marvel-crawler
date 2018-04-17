require 'marvel_crawler/version'
require 'marvel_crawler/api_client'

module MarvelCrawler
  class << self
    # Alias for MarvelCrawler::ApiClient.new
    # @return [MarvelCrawler::ApiClient]
    def client
      @api_client ||= MarvelCrawler::ApiClient.new
    end
  end
end
