Given /^the following table$/ do |table|
end

When /^I pass an "([^"]*)"$/ do |argument|
end

When /^a.+Step fails$/ do
  raise "Crash!"
end

When /^a Step is pending$/ do
  pending
end

Given /^a Background step$/ do; end
Given /^I do something$/ do; end
When /^I do something else$/ do; end
Then /^I should see stuff$/ do; end
Then /^the entire Scenario should pass$/ do; end
Then /^the entire Scenario should fail$/ do; end
Then /^the entire Scenario should be pending$/ do; end
Then /^the first Scenario should be failing$/ do; end
Then /^the following Scenarios should be skipped$/ do; end
Then /^Cuukie should be OK with it$/ do; end
Given /^I say$/ do |smart_stuff|; end
