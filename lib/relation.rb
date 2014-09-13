require 'sinatra'
require 'redis'
require 'pry'
require 'json'

class Relation < Sinatra::Base

end

#index
get '/relations' do
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  show = @relation.keys.sort
  "all the keys #{show}"
end

#read
get '/relation' do
  content_type :json
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  object = @relation.get(params[:object])
  if !object
    {error: "no relation object"}.to_json
  else
    object
  end
end

#create
post '/relation/new' do
  content_type :json
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  object = JSON.parse(request.body.read)
  @relation.set('test8', object.to_json)
  if @relation.save
    status 201
  else
    status 500
  end
end
