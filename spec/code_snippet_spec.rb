require 'cuukie/cucumber/formatter/code_snippet'
require 'tempfile'

describe "The Cuukie::code_snippet method" do
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
    snippet = Cuukie::code_snippet @source.path, 4
    snippet[:marked_line].should == 4
  end
  
  it "returns nil if it cannot find the file" do
    snippet = Cuukie::code_snippet 'no_such_file.txt', 4
    snippet.should be_nil
  end
  
  it "returns nil if the file is not valid" do
    snippet = Cuukie::code_snippet '', 4
    snippet.should be_nil
  end
  
  it "returns nil if it cannot find the line" do
    snippet = Cuukie::code_snippet @source.path, 7
    snippet.should be_nil
  end
  
  it "returns a snippet of the lines around the marked line" do
    snippet = Cuukie::code_snippet @source.path, 5
    snippet[:lines].should == "line_three()\nline_four.each do |x|\n  x.line_five\nend # line six\n"
  end
  
  it "has a first line number" do
    snippet = Cuukie::code_snippet @source.path, 5
    snippet[:first_line].should == 3
  end
  
  it "clips lines at the beginning of the file" do
    snippet = Cuukie::code_snippet @source.path, 2
    snippet[:lines].should == "# line one\nline_two = 2\nline_three()\n"
    snippet[:first_line].should == 1
  end
  
  it "clips lines at the end of the file" do
    snippet = Cuukie::code_snippet @source.path, 6
    snippet[:lines].should == "line_four.each do |x|\n  x.line_five\nend # line six\n"
    snippet[:first_line].should == 4
  end
end

describe "The Cuukie::backtrace_to_snippet method" do
  it "extracts file and line from a backtrace" do
    begin
      1 / 0
    rescue Exception => e
      expected = {:first_line => 66,
                  :marked_line => 68,
                  :lines => "  it \"extracts file and line from a backtrace\" do\n    begin\n      1 / 0\n    rescue Exception => e\n"}
      Cuukie::backtrace_to_snippet(e.backtrace).should == expected
    end
  end

  it "returns nil if the extraction fails" do
    Cuukie::backtrace_to_snippet(['abcd']).should == ['', 0]
  end
end
