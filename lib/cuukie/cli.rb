require 'optparse'

Version = File.read File.dirname(__FILE__) + '/../../VERSION' unless Kernel.const_defined? :Version

module Cuukie
  module Cli
    def parse_options(options)
      result = { :wait              => true,
                 :showpage          => false,
                 :leave_server_open => false,
                 :cuukieport        => '4569' }

      options << '-h' if options.empty?
      
      OptionParser.new do |opts|
        opts.banner = "cuukie #{::Version}\nUsage: cuukie [options] [cucumber-options]"

        opts.on("--[no-]wait", "Wait for keypress before closing the server") do |v|
          result[:wait] = v
        end

        opts.on("--showpage", "Open the Cuukie results page in the default browser") do |v|
          result[:showpage] = v
        end

        opts.on("--leave_server_open", "Don't close the server on exit") do |v|
          result[:leave_server_open] = v
        end

        opts.on("--cuukieport PORT", "Start the server on PORT (instead of the default 4569)") do |port|
          result[:cuukieport] = port
        end

        opts.on_tail("-h", "--help", "You're looking at it") do
          result = {}
          puts opts.help
        end
      end.parse! options
      result
    end
  end
end
