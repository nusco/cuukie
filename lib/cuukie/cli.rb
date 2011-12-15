require 'optparse'

Version = File.read File.dirname(__FILE__) + '/../../VERSION' unless Kernel.const_defined? :Version

module Cuukie
  module Cli
    def parse_options(options)
      result = { :cuukieport  => '4569',
                 :showpage    => false,
                 :nowait      => false,
                 :keepserver  => false }

      options << '-h' if options.empty?
      
      OptionParser.new do |opts|
        opts.banner = "cuukie #{::Version}\nUsage: cuukie [options] [cucumber-options]"

        opts.on("--cuukieport PORT", "Start the server on PORT (instead of the default 4569)") do |port|
          result[:cuukieport] = port
        end

        opts.on("--showpage", "Open the features in the default browser") do
          result[:showpage] = true
        end

        opts.on("--nowait", "Don't wait for keypress on exit") do
          result[:nowait] = true
        end

        opts.on("--keepserver", "Leave the server running on exit") do
          result[:keepserver] = true
        end

        opts.on_tail("-h", "--help", "You're looking at it") do
          puts opts.help
          return {}
        end
      end.parse! options
      result
    end
  end
end
