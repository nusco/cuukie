require 'spec_helper'

describe "The cuukie_server command" do
  it "starts the Cuukie server on port 4569 by default" do
    start_process "ruby bin/cuukie_server >/dev/null 2>&1"
    wait_for_server_on_port 4569
    stop_server_on_port 4569
  end

  it "starts the Cuukie server on any given port" do
    start_process "ruby bin/cuukie_server 4570 >/dev/null 2>&1"
    wait_for_server_on_port 4570
    stop_server_on_port 4570
  end
end

describe "The cuukie formatter" do
  it "fails gracefully if the server is down" do
    cmd = "cd spec/test_project && cucumber --format cuukie >/dev/null 2>&1"
    system(cmd).should be_true
  end
end
