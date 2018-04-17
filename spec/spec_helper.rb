require "bundler/setup"
require "marvel_crawler"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_get(path, options = {})
  klass = MarvelCrawler::Klass.new
  klass.body = JSON.parse(File.read("spec/fixtures/#{path}.json"))
  MarvelCrawler::ApiResponse.new(klass).format_response
end