require 'sinatra'
require 'json'

$FEATURES = []

get '/' do
  @features = $FEATURES
  erb :index
end

post '/features' do
  $FEATURES << JSON.parse(request.body.read)
  'OK'
end
