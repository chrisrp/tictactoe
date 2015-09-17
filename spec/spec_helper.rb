require 'sinatra'
require 'rack/test'
require 'webmock/rspec'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

def app
  Sinatra::Application
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
