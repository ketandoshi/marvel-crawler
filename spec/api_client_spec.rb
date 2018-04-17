require "spec_helper"

RSpec.describe MarvelCrawler::ApiClient do
  describe '.configure' do
    let(:client) { MarvelCrawler.client }

    it 'sets the api_key and private_key and record_per_page' do
      client.configure do |config|
        config.api_key = 'api_key_xyz'
        config.private_key = 'private_key_xyz'
        config.record_per_page = 10
      end

      expect(client.api_key).to eq 'api_key_xyz'
      expect(client.private_key).to eq 'private_key_xyz'
      expect(client.record_per_page).to eq 10
    end
  end
end