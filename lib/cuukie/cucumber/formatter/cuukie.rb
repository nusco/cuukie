require 'rest-client'
require 'json'

module Cucumber
  module Formatter
    class Cuukie
      def initialize(*)
        ping
      rescue
        puts 'I cannot find the cuukie_server on localhost:4569.'
        puts 'Please start the server with the cuukie_server command.'
        exit
      end

      def before_features(features)
        post 'before_features'
      end

      def before_feature(feature)
        # TODO: use symbols as hash keys?
        post 'before_feature', { 'short_name' => feature.short_name,
                                 'description' => feature.description }
      end
  
      def scenario_name(keyword, name, file_colon_line, source_indent)
        post 'scenario_name', { 'keyword' => keyword,
                                'name' => name,
                                'file_colon_line' => file_colon_line }
      end

      def before_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
        post 'before_step_result', { 'keyword' => keyword,
                                     'name' => step_match.format_args,
                                     'file_colon_line' => step_match.file_colon_line }
      end

      def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
        post 'after_step_result', { 'status' => status }
      end
  
      def after_steps(*)
        post 'after_steps'
      end

      def before_table_row(table_row)
        post 'before_table_row'
      end
      
      def table_cell_value(value, status)
        post 'table_cell_value', { 'value' => value }
      end
      
      def doc_string(string)
        post 'doc_string', { 'multiline_string' => string }
      end
      
      def after_features(features)
        post 'after_features', { 'duration' => features.duration }
      end

      private
  
      def post(url, params = {})
        RestClient.post "http://localhost:4569/#{url}", params.to_json
      end
      
      def ping
        RestClient.get "http://localhost:4569/ping"
      end
    end
  end
end

require 'cucumber/cli/options'
Cucumber::Cli::Options::BUILTIN_FORMATS['cuukie'] = [
  'Cucumber::Formatter::Cuukie',
  'Shows Cucumber results on a web page as they run'
]
