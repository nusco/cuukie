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
  feature['scenarios'] = []
  feature['id'] = settings.features.size + 1
  settings.features << feature
  'OK'
end

post '/scenario_name' do
  scenario = JSON.parse(request.body.read)
  scenario['steps'] = []
  scenarios = settings.features.last['scenarios']
  scenario['id'] = "#{settings.features.last['id']}_#{scenarios.size + 1}"
  scenarios << scenario
  'OK'
end

post '/before_step_result' do
  step = JSON.parse(request.body.read)
  settings.features.last['scenarios'].last['steps'] << step
  'OK'
end

post '/after_step_result' do
  current_step = settings.features.last['scenarios'].last['steps'].last
  current_step['status'] = JSON.parse(request.body.read)['status']
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }
