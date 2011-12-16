require 'optparse'

Version = File.read File.dirname(__FILE__) + '/../../VERSION' unless Kernel.const_defined? :Version

module Cuukie
  module Cli
    def parse_options(options)
      to_options_hash extract_cuukie_options(options)
    end

    private

    def extract_cuukie_options(options)
      result = []
      ['--server', '--showpage', '--nowait', '--keepserver', '-h', '--help'].each do |opt|
        result << options.delete(opt) 
      end
      if (options.include? '--cuukieport')
        port = options.delete_at(options.index('--cuukieport') + 1)
        result << options.delete('--cuukieport') << port
      end
      result.compact!
    end
    
    def to_options_hash(options)
      result = { :cuukieport  => 4569 }
      [:server, :showpage, :nowait, :keepserver, :help].each do |opt|
        result[opt] = false
      end
      
      OptionParser.new do |opts|
        opts.banner = "cuukie #{::Version}\nUsage: cuukie [options] [cucumber-options]"
        
        opts.on("--cuukieport PORT", Integer, "Start the server on PORT") {|port| result[:cuukieport] = port }
        opts.on("--server", "Run as a server")                            { result[:server] = true           }
        opts.on("--showpage", "Open the features in the default browser") { result[:showpage] = true         }
        opts.on("--nowait", "Don't wait for ENTER on exit")               { result[:nowait] = true           }
        opts.on("--keepserver", "Leave the server running on exit")       { result[:keepserver] = true       }
        
        opts.on_tail("-h", "--help", "You're looking at it") do
          puts opts.help
          result[:help] = true
        end
      end.parse! options
      result
    end
  end
end
