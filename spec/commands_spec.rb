describe "The cuukie_server command" do
  it "starts the Cuukie server" do
    Process.detach fork { exec "ruby bin/cuukie_server >/dev/null 2>&1" }
    response = nil
    until !response
      begin
        response = RestClient.get 'http://localhost:4569/ping'
      rescue; end
    end
    begin
      RestClient.delete 'http://localhost:4569/'
    rescue; end
  end
end
