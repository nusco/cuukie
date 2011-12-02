require 'server'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'The Cuukie server' do
  def app
    Sinatra::Application
  end
  
  it "shows multiple features" do
    post '/feature_name', {'keyword' => 'Feature', 'name' => 'Create User'}.to_json
    post '/feature_name', {'keyword' => 'Feature', 'name' => 'Delete User'}.to_json

    get '/'
    last_response.body.should match 'Feature: Create User'
    last_response.body.should match 'Feature: Delete User'
  end

  it "shows the names and keywords of features" do
    post '/feature_name', {'keyword' => 'Use Case', 'name' => 'Create User'}.to_json

    get '/'
    last_response.body.should match 'Use Case: Create User'
  end
end
