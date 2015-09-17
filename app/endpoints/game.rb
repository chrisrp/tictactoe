game = nil

before  do
  if request.request_method == 'POST'
    params.merge!(JSON.parse(request.body.read))
  end
end

error InvalidPickException do
  halt 422, { error: 'invalid pick' }.to_json
end

#
#
#    {
#      "player1": "foo",
#      "player2": "bar"
#    }
#
post '/game/create' do
  content_type :json

  game = Game.new

  response.status = 201
  response.body = game.start(params[:player1], params[:player2]).to_json
end

#    {
#      "current_player": "player1",
#      "x": 0,
#      "y": 0
#    }
#
post '/game/pick' do
  content_type :json

  state = game.pick(params[:current_player],
                    params[:x],
                    params[:y])

    response.status = 200
    response.body = state.to_json
end

