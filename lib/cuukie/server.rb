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
  scenario['id'] = "scenario_#{current_feature['id']}_#{current_scenarios.size + 1}"
  current_scenarios << scenario
  'OK'
end

post '/before_step_result' do
  current_scenario['steps'] << JSON.parse(request.body.read)
  'OK'
end

post '/after_step_result' do
  current_step.merge! JSON.parse(request.body.read)
  'OK'
end

get('/ping') { 'pong!' }
delete('/') { exit! }

def current_feature
  settings.features.last
end

def current_scenarios
  current_feature['scenarios']
end

def current_scenario
  current_scenarios.last
end

def current_step
  current_scenario['steps'].last
end
