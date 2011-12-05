require 'spec_helper'

describe "The cuukie_server command" do
  it "starts the Cuukie server" do
    start_process "ruby bin/cuukie_server >/dev/null 2>&1"
    wait_until_server_is_up
    stop_server
  end
end

describe "The cuukie formatter" do
  it "fails gracefully if the server is down" do
    cmd = "cd spec/test_project && cucumber --format cuukie --guess >/dev/null 2>&1"
    system(cmd).should be_true
  end
end
