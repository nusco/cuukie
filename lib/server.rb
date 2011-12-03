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
  $FEATURES << JSON.parse(request.body.read)
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }
