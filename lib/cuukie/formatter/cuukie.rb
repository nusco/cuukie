require 'rest-client'
require 'json'

class Cuukie
  def initialize(step_mother, io, options)
  end

  def before_features(features)
    RestClient.post 'http://localhost:4569/before_features', ''
  end

  def before_feature(feature)
    RestClient.post 'http://localhost:4569/before_feature',
                      { 'short_name' => feature.short_name,
                       'description' => feature.description }.to_json
  end

  def scenario_name(keyword, name, file_colon_line, source_indent)
    RestClient.post 'http://localhost:4569/scenario_name',
                      { 'name' => name,
                        'file_colon_line' => file_colon_line }.to_json
  end
end
