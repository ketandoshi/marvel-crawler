require_relative 'api_request'

module MarvelCrawler
  class ApiClient
    include MarvelCrawler::ApiRequest

    attr_accessor :api_key, :private_key, :record_per_page

    def initialize(api_key = nil, pri_key = nil, record_per_page = 5)
      # All calls to the Marvel Comics API must pass your public key via an "apikey" parameter
      @api_key = api_key
      @private_key = pri_key
      @record_per_page = record_per_page
    end

    # Customize default settings for the gem using block.
    #   MarvelCrawler::ApiClient.new.configure do |config|
    #     config.api_key = "xxx"
    #     config.private_key = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(self)
      else
        self
      end
    end
  end
end