require 'sinatra'
require 'json'
require_relative '../app/exceptions/invalid_pick'
require_relative '../app/lib/game'
require_relative '../app/endpoints/game'
require_relative '../app/endpoints/main'

configure do
  set :public_folder, File.join(File.dirname(__FILE__), '../public')
  set :show_exceptions, false
end
