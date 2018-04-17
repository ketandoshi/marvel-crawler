require "spec_helper"
require 'json'

RSpec.describe MarvelCrawler::ApiResponse do
  describe '.format_response' do
    let(:response) { stub_get('get_characters') }

    it 'formates the response' do
      expect(response).to be_instance_of(MarvelCrawler::ApiResponse)
      expect(response.response).to be_nil
      expect(response.message).not_to be_nil
    end

    it 'sets the code' do
      expect(response.code).not_to be_nil
    end

    it 'sets the status' do
      expect(response.status).not_to be_nil
    end
  end
end