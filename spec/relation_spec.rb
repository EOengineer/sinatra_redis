
require 'rack/test'
require_relative '../lib/relation'

set :environment, :test

describe Relation do
  #Database Setup
  it 'connects to a Redis database' do
    relation = Redis.new(host: '127.0.0.1', port: 6379)
    relation.flushdb
    count = relation.dbsize
    relation.set("mykey", 'myval')
    expect(relation.get("mykey")).to eq('myval')
    #relation.flushdb
  end

  it 'retrives an existing relation' do
    include Rack::Test::Methods
    get '/relation' do

    end
  end
end
