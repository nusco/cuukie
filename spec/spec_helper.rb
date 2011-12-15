require 'bundler/setup'
require 'cuukie'

require 'cuukie/client'
include Cuukie::Client

def start_process(command)
  Process.detach fork { exec command }
end

def run_cucumber(feature = '')
  system "cd spec/test_project &&
          cucumber features/#{feature} --format cuukie"
end

require 'rest-client'

[:GET, :POST, :PUT, :DELETE].each do |method|
  Kernel.send :define_method, method do |*args|
    args[0] = "http://localhost:4569#{args[0]}"
    RestClient.send method.to_s.downcase, *args
  end
end

def html
  GET('/').body
end

def start_server
  start_process "ruby bin/cuukie --server >/dev/null 2>&1"
  wait_for_server_on_port 4569
end
