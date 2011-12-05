require 'spec_helper'

describe "The cuukie_server command" do
  it "starts the Cuukie server" do
    start_process "ruby bin/cuukie_server >/dev/null 2>&1"
    wait_until_server_is_up
    stop_server
  end
end

