require 'rspec'
require 'pry'
require_relative '../lib/relation'

describe Relation do
  it 'connects to a Redis database' do
    redis = Redis.new(host: '127.0.0.1', port: 6379)
    redis.dbflush
    count = redis.dbsize
    redis.set("mykey", 'myval')
    expect(redis.get("mykey")).to eq('myval')
  end
end
