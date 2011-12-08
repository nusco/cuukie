When /^I get an exception referencing a file that doesn't exist$/ do
  begin
    1 / 0
  rescue Exception => e
    e.backtrace[0].gsub! File.dirname(__FILE__), 'no_such_directory'
    raise e
  end
end

When /^I get an exception referencing a line that doesn't exist$/ do
  begin
    1 / 0
  rescue Exception => e
    e.backtrace[0].gsub! /:[\d]+:/, ':10000:'
    raise e
  end
end

When /^I get an exception and I cannot even tell which file and line it's from$/ do
  begin
    1 / 0
  rescue Exception => e
    e.backtrace[0].gsub! /:(.*):/, 'mangle mangle'
    raise e
  end
end
