describe 'The Cuukie header' do
  before(:all) do
    start_server
  end
  
  after(:all) do
    stop_server
  end
  
  it "contains essential information" do
    run_cucumber
    html.should match '<h1>Cucumber Features</h1>'
    html.should match '<title>Cuukie</title>'
  end

  it "is red if any steps failed" do
    run_cucumber 'spec/test_project/features/create_user.feature:12'
    html.should match /failedColors\('cucumber-header'\)/
  end

  it "is yellow if any steps are pending" do
    run_cucumber 'spec/test_project/features/create_user.feature:17'
    html.should match /pendingColors\('cucumber-header'\)/
  end

  it "is green if all steps passed" do
    run_cucumber 'spec/test_project/features/create_user.feature:6'
    html.should match /passedColors\('cucumber-header'\)/
  end
end

describe 'The Cuukie content panel' do
  before(:all) do
    start_server
    run_cucumber
  end
  
  after(:all) do
    stop_server
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
    html.should match '>spec&#x2F;test_project&#x2F;features&#x2F;create_user.feature:6<'
  end
  
  it "shows the passed scenarios in green" do
    html.should match /passedColors\('scenario_1_1'\)/
  end
  
  it "shows the failed scenarios in red" do
    html.should match /failedColors\('scenario_1_2'\)/
  end
  
  it "shows the pending scenarios in yellow" do
    html.should match /pendingColors\('scenario_1_3'\)/
  end

  it "assigns a sequential id to scenarios" do
    html.should match 'id="scenario_1_2"'
  end

  it "shows the step names" do
    html.should match '>Given </span><span class="step val">I am on the Admin page</span>'
    html.should match '>When </span><span class="step val">I create a new User</span>'
  end
  
  it "shows the step source position" do
    html.should match '>spec&#x2F;test_project&#x2F;features&#x2F;step_definitions&#x2F;example_steps.rb:4<'
  end
  
  it "shows the step status" do
    html.should match 'class="step passed"'
    html.should match 'class="step pending"'
  end
  
  it "escapes step names" do
    html.should match 'I press &quot;Delete&quot;'
  end
end

require 'rest-client'

[:GET, :POST, :PUT, :DELETE].each do |method|
  Kernel.send :define_method, method do |*args|
    args[0] = "http://localhost:4569#{args[0]}"
    RestClient.send method.downcase, *args
  end
end

def start_server
  Process.detach fork { exec "ruby bin/cuukie_server >/dev/null 2>&1" }

  # wait until it's up
  loop do
    begin
      GET '/ping'
      return
    rescue; end
  end
end

def stop_server
  # the server dies without replying, so we expect an error here
  DELETE '/'
rescue
end

def html
  GET('/').body
end

def run_cucumber(features = 'spec/test_project/features')
  system "cucumber #{features} \
          --require spec/test_project/features/step_definitions/ \
          --require lib/cuukie/formatter --format Cuukie \
          --guess"
end
