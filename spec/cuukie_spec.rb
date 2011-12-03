describe 'Cuukie' do
  before(:each) do
    Server.start
  end
  
  after(:each) do
    Server.stop
  end

  it "shows a home page" do
    Server.home.body.should match '<h1>Cucumber Features</h1>'
    Server.home.body.should match '<title>Cuukie</title>'
  end

  it "cleans up previous features at the beginning of a run" do
    2.times { run_cucumber }
    Server.home.body.scan('Feature: Create User').size.should == 1
  end

  it "shows the feature names" do
    run_cucumber
    Server.home.body.should match '>Feature: Create User<'
    Server.home.body.should match '>Feature: Delete User<'
  end

  it "shows the feature narratives" do
    run_cucumber
    Server.home.body.should match '>As an Administrator<br/>I want to create a new User<br/>So that he will love me<bbr/r><'
  end

  it "shows the scenario names" do
    run_cucumber
    Server.home.body.should match '>Scenario:</span> <span class="val">New User<'
  end
end

require 'rest-client'

class Server
  class << self
    def start
      Process.detach fork { exec "ruby lib/cuukie/server.rb >/dev/null 2>&1" }

      # wait until it's up
      loop do
        begin
          GET '/ping'
          return
        rescue; end
      end
    end

    def stop
      # the server dies without replying, so we expect an error here
      DELETE '/'
    rescue
    end

    def home
      GET '/'
    end
    
    def method_missing(name, *args)
      super unless [:GET, :POST, :PUT, :DELETE].include? name.to_sym
      args[0] = "http://localhost:4569#{args[0]}"
      RestClient.send name.downcase, *args
    end
  end
end

def run_cucumber
  system 'cucumber spec/test_project/features --format Cuukie --require lib/cuukie/formatter'
end
