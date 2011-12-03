Feature: Delete User
  As an Administrator
  I want to delete a User
  So that I'll show them who's boss

Scenario: Deleted User
  Given I am on a User page
  When I press "Delete"
  Then I should not see the User anymore
