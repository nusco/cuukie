require 'sinatra/base'
require 'json'

module Cuukie
  class Server < Sinatra::Base
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
      feature = escaped_jsonized_request
      feature['description'] = feature['description'].split("\n")
      feature['scenarios'] = []
      feature['id'] = settings.features.size + 1
      settings.features << feature
      'OK'
    end

    post '/scenario_name' do
      scenario = escaped_jsonized_request
      scenario['status'] = 'undefined'
      scenario['steps'] = []
      scenario['id'] = "scenario_#{current_feature['id']}_#{current_scenarios.size + 1}"
      current_scenarios << scenario
      'OK'
    end

    post '/before_step_result' do
      current_scenario['steps'] << escaped_jsonized_request
      'OK'
    end

    post '/after_step_result' do
      current_step.merge! escaped_jsonized_request
      'OK'
    end

    post '/after_steps' do
      steps = current_scenario['steps']
      if steps.find {|step| step['status'] == 'pending' }
        current_scenario['status'] = 'pending'
      elsif steps.find {|step| step['status'] == 'failed' }
        current_scenario['status'] = 'failed'
      else
        current_scenario['status'] = 'passed'
      end
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
    
    include Rack::Utils
    
    def escaped_jsonized_request
      result = JSON.parse(request.body.read)
      result.each {|k, v| result[k] = escape_html v }
    end
  end
end