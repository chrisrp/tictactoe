require './config/boot.rb'

use Rack::PostBodyContentTypeParser
run Sinatra::Application
