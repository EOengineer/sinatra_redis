
require 'rack/test'
require_relative '../lib/relation'

def app
  Relation.new
end

describe Relation do
  include Rack::Test::Methods
  #Database Setup
  it 'connects to a Redis database' do
    relation = Redis.new(host: '127.0.0.1', port: 6379)
    relation.flushdb
    count = relation.dbsize
    relation.set("mykey", 'myval')
    expect(relation.get("mykey")).to eq('myval')
    #relation.flushdb
  end

  it 'visits home page' do
    get '/relation' do
      expect(last_response).to be_ok
      expect(last_response.body).to eq("welcome to the Relation Homepage")
    end
  end
end
