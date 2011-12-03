require 'rest-client'

module Cuukie
  class Formatter
    def initialize(step_mother, io, options)
    end
 
    def before_features(features)
      RestClient.post 'http://localhost:4569/before_features', ''
    end
    
    def before_feature(feature)
      p feature.short_name
      p feature.name
      p feature.title
      p feature.description
      RestClient.post 'http://localhost:4569/before_feature', {'short_name' => feature.short_name}.to_json
    end
  end
end
