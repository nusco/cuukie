Feature: Show Failed Background
  As a Cuker
  I want to visualize Background failures
  So that I know that everything else is skipped

Background: Failing Background
  Given a Background Step fails

Scenario: First Scenario
  Then the first Scenario should be failing

Scenario: Other Scenarios
  Then the following Scenarios should be skipped
