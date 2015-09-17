require 'sinatra'
require 'json'
require_relative '../app/exceptions/invalid_pick'
require_relative '../app/lib/game'
require_relative '../app/endpoints/game'

configure do
  set :show_exceptions, false
end
