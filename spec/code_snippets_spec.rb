require 'cuukie/cucumber/formatter/code_snippets'
require 'tempfile'

describe "The code_snippet method" do
  include Cuukie::CodeSnippets
  
  before(:all) do
    @source = Tempfile.new('source.rb')
    @source.write <<SOURCE
# line one
line_two = 2
line_three()
line_four.each do |x|
  x.line_five
end # line six
SOURCE
    @source.close
  end
  
  after(:all) do
    @source.delete
  end
  
  it "has a marked line number" do
    snippet = code_snippet @source.path, 4
    snippet[:marked_line].should == 4
  end
  
  it "returns nil if it cannot find the file" do
    snippet = code_snippet 'no_such_file.txt', 4
    snippet.should be_nil
  end
  
  it "returns nil if the file is not valid" do
    snippet = code_snippet '', 4
    snippet.should be_nil
  end
  
  it "returns nil if it cannot find the line" do
    snippet = code_snippet @source.path, 7
    snippet.should be_nil
  end
  
  it "returns a snippet of the lines around the marked line" do
    snippet = code_snippet @source.path, 5
    snippet[:raw_lines].should == "line_three()\nline_four.each do |x|\n  x.line_five\nend # line six\n"
  end
  
  it "has a first line number" do
    snippet = code_snippet @source.path, 5
    snippet[:first_line].should == 3
  end
  
  it "clips lines at the beginning of the file" do
    snippet = code_snippet @source.path, 2
    snippet[:raw_lines].should == "# line one\nline_two = 2\nline_three()\n"
    snippet[:first_line].should == 1
  end
  
  it "clips lines at the end of the file" do
    snippet = code_snippet @source.path, 6
    snippet[:raw_lines].should == "line_four.each do |x|\n  x.line_five\nend # line six\n"
    snippet[:first_line].should == 4
  end
end

describe "The backtrace_to_snippet method" do
  include Cuukie::CodeSnippets
  
  it "extracts file and line from a backtrace" do
    source = Tempfile.new('source.rb')
    source.write <<SOURCE
# one
# two
1 / 0
# four
SOURCE
    source.close
    begin
      load source.path
    rescue Exception => e
      backtrace_to_snippet(e.backtrace).should == {:first_line => 1,
                                                   :marked_line => 3,
                                                   :raw_lines => "# one\n# two\n1 / 0\n# four\n"}
    ensure
      source.delete
    end
  end

  it "returns nil if the extraction fails" do
    backtrace_to_snippet(['abcd']).should be_nil
  end
end
