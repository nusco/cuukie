require 'sinatra'
require 'json'

set :port, 4569
set :features, []

get '/' do
  @features = settings.features
  erb :index
end

post '/before_features' do
  settings.features.clear
end

post '/before_feature' do
  feature = JSON.parse(request.body.read)
  feature['description'] = feature['description'].split("\n")
  settings.features << feature
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }
