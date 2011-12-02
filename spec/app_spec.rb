require 'rest-client'

describe 'Cuukie' do
  before(:each) do
    Server.start
  end
  
  after(:each) do
    Server.stop
  end

  it "shows a home page" do
    response = Server.get '/'
    response.body.should match '<h1>Cucumber Features</h1>'
    response.body.should match '<title>Cuukie</title>'
  end

  it "cleans up previous features at the beginning of a run" do
    # FIXNE: once feature names work, just run Cucumber twice
    Server.post '/feature_name', {'name' => 'Some feature from the last run'}.to_json
    run_cucumber

    response = Server.get '/'
    response.body.should_not match 'Some feature from the last run'
  end
    
#  it "shows the names of features" do
#    system "cucumber --format Cuukie::Formatter --require lib/formatter"
#    result = RestClient.get 'http://localhost:4567/'
#    result.body.should match 'Create User'
#    result.body.should match 'Delete User'
#  end
end

class Server
  class << self
    def start
      Process.detach fork { exec "ruby lib/server.rb >& /dev/null" }

      # wait until it's up
      loop do
        begin
          RestClient.get 'http://localhost:4567/ping'
          return
        rescue; end
      end
    end

    def stop
      begin
        RestClient.delete 'http://localhost:4567/'
      rescue
        # the server dies without replying, so we expect an error here
      end
    end

    def method_missing(name, *args)
      args[0] = "http://localhost:4567#{args[0]}"
      RestClient.send name, *args
    end
  end
end

def run_cucumber
  system "cucumber --format Cuukie::Formatter --require lib/formatter"
end
