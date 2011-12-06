Given /^the following table$/ do |table|
end

When /^I pass an "([^"]*)"$/ do |argument|
  raise 'x'
end

When /I do something that results in an error/ do
  raise "Crash!"
end

When /I call a pending Step/ do
  pending
end

Given /^.*$/ do; end
