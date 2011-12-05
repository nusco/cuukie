Feature: Show Failed Background
  As a Cuker
  I want to visualize Background failures
  So that I know that everything else is skipped

Background: Failing Background
  Given I do something that results in an error

Scenario: Skipped Scenario
  When I do something
  Then the entire Scenario should be skipped anyway

Scenario: Another Skipped Scenario
  When I do something else
  Then the entire Scenario should be skipped anyway
