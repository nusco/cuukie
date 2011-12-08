require "#{File.dirname(__FILE__)}/code_snippets"
require 'rest-client'
require 'json'

module Cuukie
  class Formatter
    include ::Cuukie::CodeSnippets
    
    def initialize(step_mother, path_or_io, options)
      @server = ENV['CUUKIE_SERVER'] || 'http://localhost:4569'
      ping
    rescue
      puts "I cannot find the cuukie_server on #{@server}."
      puts "Please start the server with the cuukie_server command."
      exit
    end

    def before_features(features)
      post 'before_features'
    end

    def before_feature(feature)
      post 'before_feature', { :short_name => feature.short_name,
                               :description => feature.description }
    end

    def scenario_name(keyword, name, file_colon_line, source_indent)
      post 'scenario_name', { :keyword => keyword,
                              :name => name,
                              :file_colon_line => file_colon_line }
    end

    def before_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
      post 'before_step_result', { :keyword => keyword,
                                   :name => step_match.format_args,
                                   :file_colon_line => step_match.file_colon_line }
    end

    def exception(exception, status)
      source = backtrace_to_snippet(exception.backtrace)
      post 'exception', { :message => exception.message,
                          :backtrace => exception.backtrace.join('\n'),
                          :first_line => source[:first_line],
                          :marked_line => source[:marked_line],
                          :raw_lines => source[:raw_lines] }
    end
    
    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
      post 'after_step_result', { :status => status }
    end

    def after_steps(*)
      post 'after_steps'
    end

    def before_table_row(table_row)
      post 'before_table_row'
    end
    
    def table_cell_value(value, status)
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
    
    def ping
      RestClient.get "#{@server}/ping"
    end
  end
end

require 'cucumber/cli/options'
Cucumber::Cli::Options::BUILTIN_FORMATS['cuukie'] = [
  'Cuukie::Formatter',
  'Shows Cucumber results on a web page as they run'
]
