require 'cuukie'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'The Cuukie server' do
  def app
    Sinatra::Application
  end

  it "shows a single page" do
    get '/'
    last_response.should be_ok
    last_response.body.should match 'Cucumber Features'
  end

  it "shows the feature names" do
    post '/features', {'name' => 'Create User'}.to_json
    post '/features', {'name' => 'Delete User'}.to_json

    get '/'
    last_response.body.should match 'Feature: Create User'
    last_response.body.should match 'Feature: Delete User'
  end
end
