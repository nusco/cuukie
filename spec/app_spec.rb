require 'rest-client'

describe 'Cuukie' do
  before(:each) do
    start_server
  end
  
  after(:each) do
    stop_server
  end

  it "shows a home page" do
    response = RestClient.get 'http://localhost:4567/'
    response.body.should match '<h1>Cucumber Features</h1>'
    response.body.should match '<title>Cuukie</title>'
  end
    
#  it "shows the names of features" do
#    system "cucumber --format Cuukie::Formatter --require lib/formatter"
#    result = RestClient.get 'http://localhost:4567/'
#    result.body.should match 'Create User'
#    result.body.should match 'Delete User'
#  end
end

def start_server
  Process.detach fork { exec "ruby lib/server.rb >& /dev/null" }

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
