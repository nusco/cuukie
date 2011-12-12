require 'cuukie/cli'
require 'stringio'

describe "The parse_options method" do
  include Cuukie::Cli

  before :each do
    @out = ''
    def @out.write(data); self << data; end
    @old_stdout, $stdout = $stdout, @out
  end
  
  after :each do
    $stdout = @old_stdout
  end
  
  it "recognises --cuukieport" do
    parse_options(['--cuukieport', '4570'])[:cuukieport].should == '4570'
  end

  it "defaults to --cuukieport 4569" do
    parse_options(['--wait'])[:cuukieport].should == '4569'
  end

  it "raises error on bad --cuukieport" do
    lambda { parse_options ['--cuukieport --4569'] }.should raise_error
    lambda { parse_options ['--cuukieport'] }.should raise_error
  end
  
  it "recognises --showpage" do
    parse_options(['--showpage'])[:showpage].should be_true
  end
  
  it "defaults to --showpage = false" do
    parse_options([])[:showpage].should be_false
  end

  it "recognises --wait" do
    parse_options(['--wait'])[:wait].should be_true
  end

  it "recognises --no-wait" do
    options = ['--no-wait']
    parse_options(options)[:wait].should be_false
    options.should be_empty
  end
  
  it "defaults to --wait" do
    parse_options([''])[:wait].should be_true
  end

  it "shows the help with -h" do
    parse_options ['-h']
    @out.should match /Usage: cuukie \[/
  end

  it "shows the help with --help" do
    parse_options ['--help']
    @out.should match /Usage: cuukie \[/
  end

  it "the help text includes the version of Cuukie" do
    parse_options ['-h']
    @out.should match /cuukie \d+\.\d+\.\d+/
  end

  it "shows the help with no options" do
    parse_options []
    @out.should match /Usage: cuukie \[/
  end

  it "returns no result after showing help" do
    parse_options(['-h']).should be_empty
  end
end
