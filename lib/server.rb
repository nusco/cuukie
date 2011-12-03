require 'sinatra'
require 'json'

configure do
  set :port, 4569
end
 
$FEATURES = []

get '/' do
  @features = $FEATURES
  erb :index
end

post '/before_features' do
  $FEATURES = []
end

post '/before_feature' do
  feature = JSON.parse(request.body.read)
  feature['description'] = feature['description'].split("\n")
  $FEATURES << feature
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }
