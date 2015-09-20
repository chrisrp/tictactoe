require 'sinatra'
require 'json'
require_relative '../app/exceptions/invalid_pick_exception'
require_relative '../app/models/player'
require_relative '../lib/game_engine'
require_relative '../app/endpoints/game'

configure do
  set :public_folder, File.join(File.dirname(__FILE__), '../public')
  set :show_exceptions, false
end
