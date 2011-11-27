require 'cuukie'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'The Cuukie server' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "shows a header on the home page" do
    get '/'
    last_response.should be_ok
    last_response.body.should match 'Cucumber Features'
  end

  it "lists a single feature" do
    post '/features', {:name => 'Create User'}.to_json

    get '/'
    last_response.body.should match 'Feature: Create User'
  end
end
