require 'bundler/setup'

def start_process(command)
  Process.detach fork { exec command }
end

def run_cucumber(feature = '')
  system "cd spec/test_project &&
          cucumber features/#{feature} \
          --format cuukie \
          --guess"
end

require 'rest-client'

[:GET, :POST, :PUT, :DELETE].each do |method|
  Kernel.send :define_method, method do |*args|
    args[0] = "http://localhost:4569#{args[0]}"
    RestClient.send method.downcase, *args
  end
end

def start_server
  start_process "ruby bin/cuukie_server >/dev/null 2>&1"
  wait_until_server_is_up
end

def wait_until_server_is_up
  loop do
    begin
      GET '/ping'
      return
    rescue; end
  end
end

def stop_server
  # the server dies without replying, so we expect an error here
  DELETE '/'
rescue
end

def html
  GET('/').body
end
