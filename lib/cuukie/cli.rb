require 'optparse'
require 'ostruct'

module Cuukie
  module Cli
    def parse_options(options)
      result = OpenStruct.new
      result.showpage = false
      result.wait = true
      
      OptionParser.new do |opts|
        opts.banner = "Usage: cuukie [options]"

        opts.on("--[no-]wait", "Wait for key press at the end") do |wait|
          result.wait = wait
        end
        
        opts.on("--showpage", "Open the Cuukie page in the default browser") do |showpage|
          result.showpage = showpage
        end
      end.parse!(options)
      result
    end
  end
end
