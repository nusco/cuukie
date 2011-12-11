require 'spec_helper'

describe 'Cuukie' do
  describe "before Cucumber has run" do
    before(:all) { start_server }
    after(:all) { stop_server_on_port 4569 }
    
    it "shows a grey status bar" do
      html.should match /undefinedColors\('cucumber-header'\)/
    end

    it "shows no features" do
      html.should_not match "Feature:"
    end

    it "shows zero running time" do
      html.should match "Running time: <strong>0':0''</strong>"
    end

     it "doesn't show end-of-features stats" do
       html.should_not match /\d+ scenarios \(.*\)/
       html.should_not match /\d+ steps \(.*\)/
     end
  end

  shared_examples_for "while Cucumber is running" do
    require 'ostruct'
    
    after(:all) { stop_server_on_port 4569 }

    it "shows a grey status bar" do
      html.should match /undefinedColors\('cucumber-header'\)/
    end
    
    it "shows incomplete description for features" do
      html.should match '>...: Stuff That Works<'
      @formatter.feature_name 'Feature'
      html.should match '>Feature: Stuff That Works<'
    end
    
    it "shows incomplete scenarios in grey" do
      @formatter.scenario_name 'Scenario','Do Stuff', 'file.rb:10'
      html.should match /undefinedColors\('scenario_1_1'\)/
    end
    
    it "shows incomplete steps in grey" do
      @formatter.before_step OpenStruct.new(:keyword => 'Given',
                                            :name => 'I do something',
                                            :file_colon_line => 'file.rb:11' )
      html.should match 'class="step undefined"'
    end
    
    it "shows partial running time" do
      html.should_not match "Finished in"
      html.should match /Running time: <strong>\d+\':\d+\'\'<\/strong>/
    end
     
    it "doesn't show end-of-features stats" do
      html.should_not match /\d+ scenarios \(.*\)/
      html.should_not match /\d+ steps \(.*\)/
    end
  end
  
  describe "while Cucumber is running for the first time" do
    before(:all) do
      start_server
      @formatter = Cuukie::Formatter.new
      
      @formatter.before_features
      @formatter.before_feature OpenStruct.new(:short_name => 'Stuff That Works',
                                               :description => 'As somebody...')
    end

    it_behaves_like "while Cucumber is running"
  end
  
  describe "while Cucumber is running for the nth time" do
    before(:all) do
      start_server
      @formatter = Cuukie::Formatter.new
      
      @formatter.before_features
      @formatter.after_features OpenStruct.new(:duration => 70)

      @formatter.before_features
      @formatter.before_feature OpenStruct.new(:short_name => 'Stuff That Works',
                                               :description => 'As somebody...')
    end

    it_behaves_like "while Cucumber is running"
  end
  
  describe "once Cucumber has run" do
    before(:all) do
      start_server
      run_cucumber
    end

    after(:all) { stop_server_on_port 4569 }

    it "cleans up previous data at the beginning of a run" do
      run_cucumber
      html.scan('Feature: Visualize Scenarios').size.should == 1
    end

    it "shows the feature names" do
      html.should match '>Feature: Visualize Scenarios<'
      html.should match '>Feature: Show Failed Background<'
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
  
    it "shows passed scenarios in green" do
      html.should match /passedColors\('scenario_1_1'\)/
    end
  
    it "shows failed scenarios in red" do
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
      html.should match '>.&#x2F;features&#x2F;step_definitions&#x2F;main_steps.rb:'
    end
  
    it "shows the step status" do
      html.should match 'class="step passed"'
      html.should match 'class="step pending"'
    end

    it "shows exception messages" do
      html.should match /1_show_scenarios.feature:16<\/span><\/div>[ \n]*<div class=\"message\"><pre>Crash!/
    end

    it "shows exception backtraces" do
      html.should match 'features&#x2F;3_failed_background.feature:7:in `Given a Background Step fails&#x27;'
      html.should match '3_failed_background.feature:7:in `Given a Background Step'
    end

    it "shows exception source snippets" do
      html.should match '<pre class="ruby"><code><span class="linenum">6<\/span>'
      html.should match '<span class="keyword">raise</span> <span class="punct">&quot;</span><span class="string">Crash!'
    end
    
    it "marks the exception source in snippets" do
      html.should match '<span class="offending"><span class="linenum">8<\/span>  <span class=\"keyword\">raise'
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
    
    it "shows total running time" do
      html.should match /Duration: <strong>\d+\':\d+\'\'<\/strong>/
    end
    
    it "shows end-of-features stats" do
      run_cucumber '1_show_scenarios.feature'
      html.should match /3 scenarios \(1 failed, 1 pending, 1 passed\)/
      html.should match /11 steps \(1 failed, 2 skipped, 1 pending, 7 passed\)/
    end

    it "contains essential information in the status bar" do
      html.should match '<h1>Cucumber Features</h1>'
      html.should match '<title>Cuukie</title>'
    end

    it "shows a green status bar if all scenarios passed" do
      run_cucumber '1_show_scenarios.feature:9'
      html.should match /passedColors\('cucumber-header'\)/
    end

    it "shows a red status bar if any scenario failed" do
      run_cucumber '1_show_scenarios.feature'
      html.should match /failedColors\('cucumber-header'\)/
    end

    it "shows a yellow status bar if no scenarios failed but some are pending" do
      run_cucumber '1_show_scenarios.feature:19'
      html.should match /pendingColors\('cucumber-header'\)/
    end
  end
end
