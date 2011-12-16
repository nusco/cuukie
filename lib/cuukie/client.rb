require 'rest-client'

module Cuukie
  module Client
    def ping_at(port)
      RestClient.get "http://localhost:#{port}/ping"
    end

    def wait_for_server_at(port)
      loop do
        begin
          ping_at port
          return
        rescue; end
      end
    end

    def stop_server_at(port)
      # the server dies without replying, so we expect an error here
      RestClient.delete "http://localhost:#{port}/"
    rescue
    end
  end
end
