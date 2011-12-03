describe 'Cuukie' do
  before(:each) do
    Server.start
  end
  
  after(:each) do
    Server.stop
  end

  it "shows a home page" do
    Server.home.body.should match '<h1>Cucumber Features</h1>'
    Server.home.body.should match '<title>Cuukie</title>'
  end

  it "cleans up previous features at the beginning of a run" do
    2.times { run_cucumber }
    Server.home.body.scan('Feature: Create User').size.should == 1
  end

  it "shows the names of features" do
    run_cucumber
    Server.home.body.should match 'Feature: Create User'
    Server.home.body.should match 'Feature: Delete User'
  end
end

require 'rest-client'

class Server
  class << self
    def start
      Process.detach fork { exec "ruby lib/server.rb >& /dev/null" }

      # wait until it's up
      loop do
        begin
          GET '/ping'
          return
        rescue; end
      end
    end

    def stop
      begin
        DELETE '/'
      rescue
        # the server dies without replying, so we expect an error here
      end
    end

    def home
      GET '/'
    end
    
    def method_missing(name, *args)
      super unless [:GET, :POST, :PUT, :DELETE].include? name.to_sym
      args[0] = "http://localhost:4567#{args[0]}"
      RestClient.send name.downcase, *args
    end
  end
end

def run_cucumber
  system "cucumber spec/mock_project/features --format Cuukie::Formatter --require lib/formatter"
end