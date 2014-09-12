require 'sinatra'
require 'redis'
require 'pry'
require 'json'

class Relation < Sinatra::Base

end



get '/home' do
  "Hello World"
end

get '/relations' do
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  show = @relation.keys.sort
  "all the keys #{show}"
end

get '/relation' do
  content_type :json
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  object = @relation.get(params[:object])
  relation_name = @relation.get(params[:r_name])
  show = {object: "#{object}", relation_name: "#{relation_name}"}
  show.to_json
end
