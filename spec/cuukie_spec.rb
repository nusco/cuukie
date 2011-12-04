describe 'Cuukie' do
  before(:all) do
    Server.start
    run_cucumber
  end
  
  after(:all) do
    Server.stop
  end

  it "shows a html page" do
    html.should match '<h1>Cucumber Features</h1>'
    html.should match '<title>Cuukie</title>'
  end

  it "cleans up previous data at the beginning of a run" do
    run_cucumber
    html.scan('Feature: Create User').size.should == 1
  end

  it "shows the feature names" do
    html.should match '>Feature: Create User<'
    html.should match '>Feature: Delete User<'
  end

  it "shows the feature narratives" do
    html.should match '>As an Administrator<br/>I want to create a new User<br/>So that he will love me<bbr/r><'
  end

  it "shows the scenario names" do
    html.should match '>Scenario: </span><span class="val">New User<'
    html.should match '>Scenario: </span><span class="val">Existing User<'
  end

  it "shows the scenario source position" do
    html.should match '>spec/test_project/features/create_user.feature:6<'
  end

  it "assigns a sequential id to scenarios" do
    html.should match 'id="scenario_1_2"'
  end

  it "shows the step names" do
    html.should match '>Given </span><span class="step val">I am on the Admin page</span>'
    html.should match '>And </span><span class="step val">I press "OK"</span>'
  end

  it "shows the step source position" do
    html.should match '>spec/test_project/features/step_definitions/example_steps.rb:5<'
  end

  it "shows the test result" do
     html.should match /makeRed\('cucumber-header'\)/
  end
  
  it "shows the scenario status" do
    html.should match /makeRed\('scenario_1_2'\)/
    html.should match /makeYellow\('scenario_1_3'\)/
  end
  
  it "shows the step status" do
    html.should match 'class="step passed"'
    html.should match 'class="step pending"'
  end
end

require 'rest-client'

class Server
  class << self
    def start
      Process.detach fork { exec "ruby bin/cuukie_server >/dev/null 2>&1" }

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

    def method_missing(name, *args)
      super unless [:GET, :POST, :PUT, :DELETE].include? name.to_sym
      args[0] = "http://localhost:4569#{args[0]}"
      RestClient.send name.downcase, *args
    end
  end
end

def html
  Server.GET('/').body
end

def run_cucumber
  system 'cucumber spec/test_project/features --require spec/test_project/features/step_definitions/ --require lib/cuukie/formatter  --format Cuukie --guess'
end
