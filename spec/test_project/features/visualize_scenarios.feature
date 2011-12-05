Feature: Visualize Scenarios
  As a Cuker
  I want to visualize Scenarios and Steps
  So that I know which steps are not passing

Scenario: Passing Scenario
  Given I did something
  When I do something else
  And I pass an "argument"
  Then the entire Scenario should pass

Scenario: Failing Scenario
  When I do something that results in an error
  Then I the entire Scenario should fail

Scenario: Pending Scenario
  When I call a pending Step
  Then I the entire Scenario should be pending
