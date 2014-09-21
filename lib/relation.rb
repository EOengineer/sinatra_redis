require 'sinatra'
require 'redis'
require 'pry'
require 'json'

class Relation < Sinatra::Base

  def get_all_relations(params)

  end

  def check_relation_exists(params)

  end
end



#get all objects for given relation object
get '/relations' do
  content_type :json
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  object_key = params["object_a_type"] + ":" + params["object_a_id"] + ":" + params["relation_name"]
  object = @relation.get("#{object_key}")
  if !object
    status 404, {error: "no relation object"}.to_json
  else
    object.to_json
  end
end



get '/relation' do
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  # binding.pry
  requested_object = params["object_a_type"] + ":" + params["object_a_id"] + ":" + params["relation_name"] + ":" + params["object_b_type"] + ":" + params["obj_b_id"]
  object = @relation.get(requested_object)
  if !object
    status 404, {error: "this relation does not exist"}.to_json
  else
    status 200
  end
end



#create
post '/relation/new' do
  content_type :json
  @relation = Redis.new(host: '127.0.0.1', port: 6379)
  # binding.pry
  object = JSON.parse(request.body.read)
  record_key = "#{object["object_a_type"]}:#{object["object_a_id"]}:#{object["relation_name"]}"
  record_val = "#{object["object_b_type"]}:#{object["object_b_id"]}"
  @relation.set(record_key, record_val)



  if @relation.save
    status 201
  else
    status 500, {error: "unprocessible entity"}.to_json
  end
end
