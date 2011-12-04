require 'rest-client'
require 'json'

class Cuukie
  def initialize(step_mother, io, options)
  end

  def before_features(features)
    post 'before_features', {}
  end

  def before_feature(feature)
    post 'before_feature', { 'short_name' => feature.short_name,
                             'description' => feature.description }
  end

  def scenario_name(keyword, name, file_colon_line, source_indent)
    post 'scenario_name', { 'name' => name,
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
  
  def after_steps(steps)
    post 'after_steps', {}
  end
  
  private
  
  def post(url, params)
    RestClient.post "http://localhost:4569/#{url}", params.to_json
  end
end
