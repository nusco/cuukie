require 'spec_helper'

describe 'Cuukie' do
  before(:all) { start_server }
  after(:all) { stop_server_on_port 4569 }
  
  describe 'shows suite result at the top of the page' do
    it "contains essential information" do
      run_cucumber
      html.should match '<h1>Cucumber Features</h1>'
      html.should match '<title>Cuukie</title>'
    end

    it "shows green if all scenarios passed" do
      run_cucumber '1_show_scenarios.feature:9'
      html.should match /passedColors\('cucumber-header'\)/
    end

    it "shows red if any scenario failed" do
      run_cucumber '1_show_scenarios.feature'
      html.should match /failedColors\('cucumber-header'\)/
    end

    it "shows yellow if no scenarios failed but some are pending" do
      run_cucumber '1_show_scenarios.feature:19'
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
      html.should match '>features&#x2F;1_show_scenarios.feature:'
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
      html.should match '>features&#x2F;step_definitions&#x2F;example_steps.rb:'
    end
  
    it "shows the step status" do
      html.should match 'class="step passed"'
      html.should match 'class="step pending"'
    end

    it "shows exceptions" do
      html.should match /example_steps.rb:7<\/span><\/div>[ \n]*<div class="message"><pre>Crash!<\/pre><\/div>/
    end
  
    it "escapes HTML output" do
      html.should match 'I pass an &quot;argument&quot;'
    end
    
    it "shows tables in steps" do
      html.should match '<td class="step" id="row_-0_0"><div><span class="step param">x</span></div></td>'
      html.should match '<td class="step" id="row_-2_1"><div><span class="step param">22</span></div></td>'
    end
    
    it "shows multiline strings in steps" do
      html.should match '<pre class=\"val\">  Cuukie is sweet!\n  Let&#x27;s try it out.</pre>'
    end
    
    it "shows total duration" do
      html.should match /Finished in <strong>\d+m\d+\.\d+s seconds<\/strong>/
    end
    
    it "shows end-of-features stats" do
      run_cucumber '1_show_scenarios.feature'
      html.should match /3 scenarios \(1 failed, 1 pending, 1 passed\)/
      html.should match /11 steps \(1 failed, 2 skipped, 1 pending, 7 passed\)/
    end
  end
end
