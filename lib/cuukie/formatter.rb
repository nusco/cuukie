require File.dirname(__FILE__) + '/code_snippets'
require 'rest-client'
require 'json'

module Cuukie
  class Formatter
    include CodeSnippets
    
    def initialize(*)
      @server = ENV['CUUKIE_SERVER'] || 'http://localhost:4569'
      RestClient.get "#{@server}/ping"
    rescue
      puts "I cannot find the cuukie_server on #{@server}."
      puts "Please start the server with the cuukie_server command."
      exit
    end

    def before_features(*)
      post 'before_features'
    end

    def before_feature(feature)
      post 'before_feature', { :short_name => feature.short_name,
                               :description => feature.description }
    end

    def scenario_name(keyword, name, file_colon_line, *)
      post 'scenario_name', { :keyword => keyword,
                              :name => name,
                              :file_colon_line => file_colon_line }
    end

    def before_step(step)
      post 'before_step', { :keyword => step.keyword,
                            :name => step.name,
                            :file_colon_line => step.file_colon_line }
    end

    def exception(exception, *)
      source = backtrace_to_snippet(exception.backtrace)
      post 'exception', { :message => exception.message,
                          :backtrace => exception.backtrace.join('\n'),
                          :raw_lines => source[:raw_lines],
                          :first_line => source[:first_line],
                          :marked_line => source[:marked_line]  }
    end
    
    def after_step_result(keyword, step_match, multiline_arg, status, *)
      post 'after_step_result', { :status => status }
    end

    def after_steps(*)
      post 'after_steps'
    end

    def before_table_row(*)
      post 'before_table_row'
    end
    
    def table_cell_value(value, *)
      post 'table_cell_value', { :value => value }
    end
    
    def doc_string(string)
      post 'doc_string', { :multiline_string => string }
    end
    
    def after_features(features)
      post 'after_features', { :duration => features.duration }
    end

    private

    def post(url, params = {})
      RestClient.post "#{@server}/#{url}", params.to_json
    end
  end
end

require 'cucumber/cli/options'
Cucumber::Cli::Options::BUILTIN_FORMATS['cuukie'] = [
  'Cuukie::Formatter',
  'Shows Cucumber results on a web page as they run'
]
