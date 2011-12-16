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
  
  it "recognizes --server" do
    parse_options(['--server'])[:server].should be_true
  end
  
  it "defaults to --server = false" do
    parse_options([])[:server].should be_false
  end
  
  it "recognizes --cuukieport" do
    parse_options(['--cuukieport', '4570'])[:cuukieport].should == 4570
  end

  it "defaults to --cuukieport 4569" do
    parse_options([])[:cuukieport].should == 4569
  end

  it "raises error on bad --cuukieport" do
    lambda { parse_options ['--cuukieport', 'abc'] }.should raise_error
    lambda { parse_options ['--cuukieport'] }.should raise_error
  end
  
  it "recognizes --showpage" do
    parse_options(['--showpage'])[:showpage].should be_true
  end
  
  it "defaults to --showpage = false" do
    parse_options([])[:showpage].should be_false
  end

  it "recognizes --nowait" do
    parse_options(['--nowait'])[:nowait].should be_true
  end
  
  it "defaults to --nowait = false" do
    parse_options([])[:nowait].should be_false
  end
  
  it "recognizes --keepserver" do
    parse_options(['--keepserver'])[:keepserver].should be_true
  end
  
  it "defaults to --keepserver = false" do
    parse_options(['--nowait'])[:keepserver].should be_false
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

  it "leaves behind a help option after showing help" do
    parse_options(['-h'])[:help].should be_true
  end
  
  it "consumes recognized options" do
    options = ['--showpage', '--invalid', '--cuukieport', '4570']
    parse_options options
    options.should == ['--invalid']
  end
end
