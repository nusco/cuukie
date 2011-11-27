require 'sinatra'
require 'json'

$FEATURE = ''

get '/' do
  @feature = $FEATURE
  erb :index
end

post '/features' do
  $FEATURE = JSON.parse request.body.read
end
