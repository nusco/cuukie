Feature: Exception with no source
  As a Cuker
  I want to visualize exceptions even if I cannot retrieve the code
  So that I can still use Cuukie when the source is on another machine
  
Scenario: Exception with unknown file
  When I get an exception referencing a file that doesn't exist
  Then Cuukie should be OK with it

Scenario: Exception with wrong line
  When I get an exception referencing a line that doesn't exist
  Then Cuukie should be OK with it

Scenario: Exception with mangled backtrace
  When I get an exception and I cannot even tell which file and line it's from
  Then Cuukie should be OK with it
