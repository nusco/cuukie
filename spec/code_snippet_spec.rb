require 'cuukie/cucumber/formatter/code_snippet'
require 'tempfile'

describe Cuukie::CodeSnippet do
  before(:all) do
    @source = Tempfile.new('source.rb')
    @source.write <<SOURCE
# line one


line_four += 4
line_five.each do |x|
  x.line_six
end # line seven
SOURCE
    @source.close
  end
  
  after(:all) do
    @source.delete
  end
  
  it "has a marked line number" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 7)
    snippet.marked_line.should == 7
  end
  
  it "returns nil if it cannot find the file" do
    snippet = Cuukie::CodeSnippet.new('no_such_file.rb', 7)
    snippet.lines.should be_nil
  end
  
  it "returns nil if it cannot find the line" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 8)
    snippet.lines.should be_nil
  end
  
  it "returns a snippet of the lines around the marked line" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 6)
    snippet.lines.should == "line_four += 4\nline_five.each do |x|\n  x.line_six\nend # line seven\n"
  end
  
  it "has a first line number" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 6)
    snippet.first_line.should == 4
  end
  
  it "clips lines at the beginning of the file" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 2)
    snippet.lines.should == "# line one\n\n\n"
    snippet.first_line.should == 1
  end
  
  it "clips lines at the end of the file" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 7)
    snippet.lines.should == "line_five.each do |x|\n  x.line_six\nend # line seven\n"
    snippet.first_line.should == 5
  end
  
  it "removes empty trailing lines" do
    snippet = Cuukie::CodeSnippet.new(@source.path, 4)
    snippet.lines.should == "line_four += 4\nline_five.each do |x|\n"
    snippet.first_line.should == 4
  end
end
