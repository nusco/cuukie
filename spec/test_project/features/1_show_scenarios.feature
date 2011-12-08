Feature: Visualize Scenarios
  As a Cuker
  I want to visualize Scenarios and Steps
  So that I know which steps are not passing

Background: Common Steps
  Given a Background step

Scenario: Passing Scenario
  And I do something
  When I do something else
  And I pass an "argument"
  Then the entire Scenario should pass

Scenario: Failing Scenario
  When a Step fails
  Then the entire Scenario should fail

Scenario: Pending Scenario
  When a Step is pending
  Then the entire Scenario should be pending
