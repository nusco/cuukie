require 'rest-client'

module Cuukie
  class Formatter
    def initialize(step_mother, io, options)
    end
 
    def before_features(features)
      RestClient.post 'http://localhost:4569/before_features', ''
    end
    
    def before_feature(feature)
      RestClient.post 'http://localhost:4569/before_feature',
                        {'short_name' => feature.short_name,
                         'description' => feature.description}.to_json
    end
  end
end
