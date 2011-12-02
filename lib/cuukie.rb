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
  feature = JSON.parse(request.body.read)
  feature['keyword'] = 'Feature' unless feature['keyword'] # is this necessary with a Cucumber formatter?
  $FEATURES << feature
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }
