Feature: Show Multiline Arguments
  As a Cuker
  I want to see multiline arguments in the result
  To see everything about steps
  
Scenario: Show tables
  Given the following table
    | x  | y  |
    | 1  | 2  |
    | 11 | 22 |
  Then Cuukie should be OK with it

Scenario: Show tables
  Given I say
    """
      Cuukie is sweet!
      Let's try it out.
    """
  Then Cuukie should be OK with it
