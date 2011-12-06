Feature: Visualize Scenarios
  As a Cuker
  I want to visualize Scenarios and Steps
  So that I know which steps are not passing

Background: Common Steps
  Given I execute a Background step

Scenario: Passing Scenario
  And I do something
  When I do something else
  And I pass an "argument"
  Then the entire Scenario should pass

Scenario: Failing Scenario
  When I do something that results in an error
  Then the entire Scenario should fail

Scenario: Pending Scenario
  And the following table
    | x  | y  |
    | 1  | 2  |
    | 11 | 22 |
  When I call a pending Step
  Then the entire Scenario should be pending
