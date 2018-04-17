module MarvelCrawler
  class ApiResponse

    attr_accessor :response, :code, :status, :results, :etag, :offset, :limit, :total, :count, :message

    def initialize(response)
      @response = response.body
      @code = @response['code']
      @status = @response['status']
      @results = nil
      @etag = nil
      @offset = nil
      @limit = nil
      @total = nil
      @count = nil
      @message = nil
    end

    def format_response
      case @code
        when 200
          @results = @response['data']['results'].dup
          @etag = @response['etag']
          @offset = @response['data']['offset']
          @limit = @response['data']['limit']
          @total = @response['data']['total']
          @count = @response['data']['count']
          @message = 'Success'
        when 304
          @message = 'Not Modified'
        else
          @message = "Error: #{@response['status']}"
      end
      @response = nil

      self
    end

  end

  # Class for testing purpose
  class Klass
    attr_accessor :body
  end
end