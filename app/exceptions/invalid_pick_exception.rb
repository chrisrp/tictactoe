InvalidPickException = Class.new(StandardError)

error InvalidPickException do
  halt 422, { error: 'invalid pick' }.to_json
end
