Given /^the following table$/ do |table|
end

When /^I pass an "([^"]*)"$/ do |argument|
end

When /I do something that results in an error/ do
  raise "Crash!"
end

When /I call a pending Step/ do
  pending
end

Given /^I execute a Background step$/ do; end
Given /^I do something$/ do; end
When /^I do something else$/ do; end
Then /^I should see stuff$/ do; end
Then /^the entire Scenario should pass$/ do; end
Then /^the entire Scenario should fail$/ do; end
Then /^the entire Scenario should be pending$/ do; end
Then /^the entire Scenario should be skipped anyway$/ do; end
Then /^Cuukie should be OK with it$/ do; end
Given /^I say$/ do |smart_stuff|; end
