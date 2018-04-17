require "spec_helper"
require 'json'

RSpec.describe MarvelCrawler::ApiRequest do
  let(:client) { MarvelCrawler.client }

  context 'initialization' do
    let(:all_routes) { MarvelCrawler::ApiRequest::MARVEL_API_ROUTES }

    context 'Generates all the Marvel Comics API methods in meta class' do
      it 'has all api routes defined in hash' do
        expect(all_routes).to_not be_nil
        expect(all_routes).to be_instance_of(Hash)
        expect(all_routes.keys.sort).to eq([:characters, :comics, :creators, :events, :series, :stories])
      end

      it 'has generated all methods to invoke different apis' do
        all_routes.each do |group_name, group_methods|
          group_methods.each do |method_name|
            expect(client.respond_to?("get_#{method_name.to_sym}")).to be true
          end
        end
      end
    end
  end

  describe '.check_for_credentials' do
    it 'requires :api_key to be set' do
      client.api_key = nil

      expect{ client.get_characters }
        .to raise_exception(MarvelCrawler::ApiRequest::InvalidClientError, 'You need to provide :api_key param.')
    end

    it 'requires :private_key to be set' do
      client.api_key = 'api_key_xyz'
      client.private_key = nil

      expect{ client.get_characters }
        .to raise_exception(MarvelCrawler::ApiRequest::InvalidClientError, 'You need to provide :private_key param.')
    end
  end

  describe '.make_request' do
    it 'gets the list of characters' do
      # Fake the request
      response = stub_get('get_characters')

      expect(response).to be_instance_of(MarvelCrawler::ApiResponse)
      expect(response.results).to be_instance_of(Array)
      expect(response.results.first).to be_instance_of(Hash)
      expect(response.results.first.keys.sort)
        .to eq(["comics", "description", "events", "id", "modified", "name", "resourceURI", "series", "stories", "thumbnail", "urls"])
      expect(response.results.collect.collect{|h| h['name']}).to eq(["3-D Man", "A-Bomb (HAS)"])
    end

    it 'gets the details of a character 1011334' do
      # Fake the request
      response = stub_get('get_character', {id: 1011334})

      expect(response).to be_instance_of(MarvelCrawler::ApiResponse)
      expect(response.results).to be_instance_of(Array)
      expect(response.results.first).to be_instance_of(Hash)
      expect(response.results.first['id']).to eq(1011334)
      expect(response.results.first['name']).to eq('3-D Man')
    end

  end

end