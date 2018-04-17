require "spec_helper"

RSpec.describe MarvelCrawler do
  it "has a version number" do
    expect(MarvelCrawler::VERSION).not_to be nil
  end

  describe '.client' do
    it 'returns a MarvelCrawler::ApiClient' do
      expect(MarvelCrawler.client).to be_a MarvelCrawler::ApiClient
    end
  end
end
