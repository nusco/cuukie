require 'rest-client'

module Cuukie
  class Formatter
    def initialize(step_mother, io, options)
    end
 
    def before_features(features)
      RestClient.post 'http://localhost:4567/before_features', ''
    end
    
#    def feature_name(keyword, name)
#      RestClient.post 'http://localhost:4567/feature_name', {'name' => name}.to_json
#    end
  end
end