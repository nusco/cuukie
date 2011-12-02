require 'cuukie'
require 'rest-client'

describe 'Cuukie' do
  before(:each) do
    start_server
  end
  
  after(:each) do
    stop_server
  end
  
  it "does things" do
  end
end

def start_server
  Process.detach fork { exec "ruby lib/cuukie.rb >& /dev/null" }

  # wait until it's up
  loop do
    begin
      RestClient.get 'http://localhost:4567/ping'
      return
    rescue; end
  end
end

def stop_server
  begin
    RestClient.delete 'http://localhost:4567/'
  rescue
    # the server dies without replying, so we expect an error here
  end
end
