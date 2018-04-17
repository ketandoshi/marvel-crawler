require 'faraday'
require 'faraday_middleware'

module MarvelCrawler
  class Connection

    @@active_connection = nil

    attr_accessor :base_url, :headers

    def initialize
      @base_url = 'https://gateway.marvel.com/v1/public/'
      @headers = {
        content_type: 'application/json',
        user_agent: "marvel_crawler v#{MarvelCrawler::VERSION}"
      }
    end

    def connect
      return @@active_connection unless @@active_connection.nil?

      options = {
        url: @base_url,
        headers: @headers
      }

      @@active_connection = Faraday.new(options) do |conn|
        # Request encodes as "application/x-www-form-urlencoded" if not already encoded or of another type
        conn.use Faraday::Request::UrlEncoded
        # Converts parsed response bodies to a Hashie::Mash if they were of Hash or Array type
        # conn.use Faraday::Response::Mashify
        # Parse the json response
        conn.use Faraday::Response::ParseJson
        # Make requests with Net::HTTP
        conn.adapter(Faraday.default_adapter)
      end
    end
  end
end