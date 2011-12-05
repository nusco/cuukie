require 'sinatra/base'
require 'json'

module Cuukie
  class Server < Sinatra::Base
    set :port, 4569
    set :features, []
    set :build_status, nil
    
    get '/' do
      @features = settings.features
      @build_status = settings.build_status
      erb :index
    end

    post '/before_features' do
      settings.features.clear
      settings.build_status = nil
    end

    post '/before_feature' do
      feature = read_from_request
      feature['description'] = feature['description'].split("\n")
      feature['scenarios'] = []
      feature['id'] = settings.features.size + 1
      settings.features << feature
      'OK'
    end

    post '/background_name' do
      scenario = read_from_request
      scenario['steps'] = []
      scenario['id'] = "scenario_#{current_feature['id']}_#{current_feature['scenarios'].size + 1}"
      current_feature['scenarios'] << scenario
      'OK'
    end

    post '/scenario_name' do
      scenario = read_from_request
      scenario['steps'] = []
      scenario['id'] = "scenario_#{current_feature['id']}_#{current_feature['scenarios'].size + 1}"
      current_feature['scenarios'] << scenario
      'OK'
    end

    post '/before_step_result' do
      current_scenario['steps'] << read_from_request
      'OK'
    end

    post '/after_step_result' do
      current_step.merge! read_from_request
      if current_step['status'] == 'failed'
        current_scenario['status'] = settings.build_status = 'failed' 
      elsif current_step['status'] == 'pending'
        current_scenario['status'] = 'pending'
        settings.build_status ||= 'pending' 
      end
      'OK'
    end

    post '/after_steps' do
      current_scenario['status'] ||= 'passed'
      'OK'
    end

    post '/after_features' do
      settings.build_status ||= 'passed'
      'OK'
    end
    
    get('/ping') { 'pong!' }
    delete('/') { exit! }

    def current_feature;  settings.features.last            ;end
    def current_scenario; current_feature['scenarios'].last ;end
    def current_step;     current_scenario['steps'].last    ;end
    
    include Rack::Utils
    
    def read_from_request
      result = JSON.parse request.body.read
      result.each {|k, v| result[k] = escape_html v }
    end
  end
end