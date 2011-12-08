require 'sinatra/base'
require 'json'
require 'syntax/convertors/html'

module Cuukie
  class Server < Sinatra::Base
    set :features,      []
    set :build_status,  'undefined'
    set :duration,      '?'
    set :stats,         {:scenarios => '', :steps => ''}
    
    get '/' do
      @features     = settings.features
      @build_status = settings.build_status
      @duration     = settings.duration
      @stats        = settings.stats
      erb :index
    end

    post '/before_features' do
      settings.features.clear
      settings.build_status = 'undefined'
      settings.stats = {:scenarios => '', :steps => ''}
      settings.duration = '?'
    end

    post '/before_feature' do
      feature = read_from_request
      feature[:description] = feature[:description].split("\n")
      feature[:scenarios] = []
      feature[:id] = settings.features.size + 1
      settings.features << feature
      'OK'
    end

    post '/scenario_name' do
      scenario = read_from_request
      scenario[:steps] = []
      scenario[:id] = "scenario_#{current_feature[:id]}_#{current_feature[:scenarios].size + 1}"
      scenario[:status] = 'undefined'
      current_feature[:scenarios] << scenario
      'OK'
    end

    post '/before_step_result' do
      step = read_from_request
      step[:table] = []
      current_scenario[:steps] << step
      'OK'
    end

    post '/exception' do
      current_step[:exception] = read_from_request
      'OK'
    end
    
    post '/after_step_result' do
      current_step.merge! read_from_request
      if current_step[:status] == 'failed'
        current_scenario[:status] = settings.build_status = 'failed' 
      elsif current_step[:status] == 'pending'
        current_scenario[:status] = 'pending'
        settings.build_status = 'pending' if settings.build_status == 'undefined'
      end
      'OK'
    end

    post '/after_steps' do
      if current_scenario[:steps].all? {|step| step[:status] == 'skipped' }
        current_scenario[:status] = 'skipped'
      end
      current_scenario[:status] = 'passed' if current_scenario[:status] == 'undefined'
      'OK'
    end
    
    post '/before_table_row' do
      current_step[:table] << []
      'OK'
    end
    
    post '/table_cell_value' do
      data = read_from_request
      current_step[:table].last << data[:value]
      'OK'
    end
    
    post '/doc_string' do
      data = read_from_request
      current_step[:multiline_string] = data[:multiline_string]
      'OK'
    end
    
    post '/after_features' do
      data = read_from_request
      min, sec = data[:duration].to_f.divmod(60)
      settings.duration = "#{min}m#{'%.3f' % sec}s" 
      settings.build_status = 'passed' if settings.build_status == 'undefined'
      settings.stats = stats
      'OK'
    end

    get('/ping') { 'pong!' }
    delete('/') { exit! }
    
    helpers do
      def code_snippet_for(exception)
        return '' unless exception[:raw_lines]
        result = '<pre class="ruby"><code>'
        linenum = exception[:first_line]
        html_lines = htmlize(exception[:raw_lines]).split "\n"
        html_lines.each do |html_line|
          line = "<span class=\"linenum\">#{linenum}</span>#{html_line}"
          line = "<span class=\"offending\">#{line}</span>" if linenum == exception[:marked_line]
          result << "#{line}<br/>"
          linenum += 1
        end
        result << '</code></pre>'
      end
    end
    
    def current_feature
      settings.features.last
    end

    def current_scenario
      # return a "nil scenario" (that includes a "nil step") if we
      # don't have a scenario yet. this is useful to eliminate steps
      # coming from backgrounds (which will be re-sent during the
      # following scenarios anyway)
      return { :steps => [{}] } if current_feature[:scenarios].empty?
      current_feature[:scenarios].last
    end

    def current_step
      current_scenario[:steps].last
    end
    
    def stats
      scenarios = []
      settings.features.each {|feature| scenarios.concat feature[:scenarios] }

      result = {:scenarios => String.new, :steps => String.new}
      result[:scenarios] << pluralize(scenarios.size, "scenario")
      result[:scenarios] << counts(scenarios)
      
      steps = []
      scenarios.each {|scenario| steps.concat scenario[:steps] }
      result[:steps] << pluralize(steps.size, "step")
      step_count = counts steps
      result[:steps] << step_count if step_count
      result
    end

    def pluralize(count, what)
      "#{count} #{what}#{count == 1 ? '' : 's'}"
    end    
    
    def counts(elements)
      counts = ['failed', 'skipped', 'undefined', 'pending', 'passed'].map do |status|
        selected = elements.find_all {|element| element[:status] == status }
        selected.any? ? "#{selected.size} #{status}" : nil
      end.compact
      counts.any? ? " (#{counts.join(', ')})" : ''
    end
    
    def htmlize(ruby)
      convertor = Syntax::Convertors::HTML.for_syntax("ruby")
      convertor.convert(ruby, false)
    end
    
    include Rack::Utils
    
    def read_from_request
      data = JSON.parse request.body.read
      result = {}
      data.each do |k, v|
        if v.class == String && k !~ /^raw_/
          result[k.to_sym] = escape_html(v)
        else
          result[k.to_sym] = v
        end
      end
      result
    end
  end
end
