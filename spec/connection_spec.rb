require "spec_helper"

RSpec.describe MarvelCrawler::Connection do
  let(:connection_obj) { MarvelCrawler::Connection.new }
  let(:faraday_connection_obj) { connection_obj.connect }

  describe '.new' do
    it 'returns a MarvelCrawler::Connection' do
      expect(connection_obj).to be_a MarvelCrawler::Connection
    end

    it 'should have base_url and headers' do
      expect(connection_obj.base_url).not_to be_nil
      expect(connection_obj.base_url).to eq('https://gateway.marvel.com/v1/public/')
      expect(connection_obj.headers).not_to be_nil
      expect(connection_obj.headers).to eq({
                                             content_type: 'application/json',
                                             user_agent: "marvel_crawler v#{MarvelCrawler::VERSION}"
                                           })
    end
  end

  describe '.connect' do
    it 'return a Faraday::Connection' do
      expect(faraday_connection_obj).not_to be_nil
      expect(faraday_connection_obj).to be_instance_of(Faraday::Connection)
    end
  end
end