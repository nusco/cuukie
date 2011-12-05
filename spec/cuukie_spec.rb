describe 'Cuukie' do
  before(:all) { start_server }
  after(:all) { stop_server }
  
  describe 'on the page header' do
    it "contains essential information" do
      run_cucumber
      html.should match '<h1>Cucumber Features</h1>'
      html.should match '<title>Cuukie</title>'
    end

    it "is green if all scenarios passed" do
      run_cucumber '1_visualize_scenarios.feature:9'
      html.should match /passedColors\('cucumber-header'\)/
    end

    it "is red if any scenario failed" do
      run_cucumber '1_visualize_scenarios.feature'
      html.should match /failedColors\('cucumber-header'\)/
    end

    it "is yellow if no scenarios failed but some are pending" do
      run_cucumber '1_visualize_scenarios.feature:19'
      html.should match /pendingColors\('cucumber-header'\)/
    end
  end

  describe 'in the content area' do
    before(:all) { run_cucumber }

    it "cleans up previous data at the beginning of a run" do
      run_cucumber
      html.scan('Feature: Visualize Scenarios').size.should == 1
    end

    it "shows the feature names" do
      html.should match '>Feature: Visualize Scenarios<'
      html.should match '>Feature: Multiple Features<'
    end

    it "shows the feature narratives" do
      html.should match '>As a Cuker<br/>I want to visualize Scenarios and Steps<br/>So that I know which steps are not passing<bbr/r><'
    end

    it "shows the scenario names" do
      html.should match '>Scenario: </span><span class="val">Passing Scenario<'
      html.should match '>Scenario: </span><span class="val">Failing Scenario<'
    end

    it "shows the scenario source position" do
      html.should match '>features&#x2F;1_visualize_scenarios.feature:9<'
    end
  
    it "shows the passed scenarios in green" do
      html.should match /passedColors\('scenario_1_1'\)/
    end
  
    it "shows the failed scenarios in red" do
      html.should match /failedColors\('scenario_3_1'\)/
    end
  
    it "shows the skipped scenarios in yellow" do
      # This can happen if there is an error in a Background step.
      # In this case, all the scenarios past the first one are skipped.
      html.should match /skippedColors\('scenario_3_2'\)/
    end

    it "assigns a sequential id to feature elements" do
      html.should match 'id="scenario_1_2"'
    end

    it "shows the step names" do
      html.should match '>And </span><span class="step val">I do something</span>'
      html.should match '>When </span><span class="step val">I do something else</span>'
    end
  
    it "shows the step source position" do
      html.should match '>features&#x2F;step_definitions&#x2F;example_steps.rb:4<'
    end
  
    it "shows the step status" do
      html.should match 'class="step passed"'
      html.should match 'class="step pending"'
    end
  
    it "escapes step names" do
      html.should match 'I pass an &quot;argument&quot;'
    end
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

def run_cucumber(feature = '')
  system "cd spec/test_project &&
          cucumber features/#{feature} \
          --format cuukie \
          --guess"
end
