require 'cuukie/cli'

describe "The parse_options method" do
  include Cuukie::Cli

  it "recognises --showpage" do
    parse_options(["--showpage"]).showpage.should be_true
  end
  
  it "defaults to false --showpage" do
    parse_options([""]).showpage.should be_false
  end

  it "recognises --wait" do
    parse_options(["--wait"]).wait.should be_true
  end

  it "recognises --no-wait" do
    parse_options(["--no-wait"]).wait.should be_false
  end
  
  it "defaults to true --wait" do
    parse_options([""]).wait.should be_true
  end
end
