game = Game.new

before  do
  if request.request_method == 'POST'
    params.merge!(JSON.parse(request.body.read))
  end
end

post '/game/create' do
  content_type :json

  response.status = 201
  response.body = game.start(params[:player1], params[:player2]).to_json
end

post '/game/pick' do
  content_type :json

  state = game.pick(params[:current_player],
                    params[:x],
                    params[:y])

  response.status = 200
  response.body = state.to_json
end

