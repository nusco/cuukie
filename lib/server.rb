require 'sinatra'
require 'json'

$FEATURES = []

get '/' do
  @features = $FEATURES
  erb :index
end

post '/before_features' do
  $FEATURES = []
end

post '/feature_name' do
  $FEATURES << JSON.parse(request.body.read)
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }
