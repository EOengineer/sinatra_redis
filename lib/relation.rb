require 'sinatra'
require 'redis'

class Relation
end

  get "/relation" do
    "welcome to the Relation Homepage"
  end

  get "/relation/new/:id" do
    relation = Redis.new(host: '127.0.0.1', port: 6379)
    show = "#{params[:id]}"
    relation.set(show ,'testvals')
    redirect "/relation/#{params[:id]}"
  end

  get "/relation/:key" do
    relation = Redis.new(host: '127.0.0.1', port: 6379)
    test = relation.get("#{params[:key]}")
    if test == nil
      "bad key dude"
    else
      test + " showing now for #{params[:key]} on a show page"
    end
  end

