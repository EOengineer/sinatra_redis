
require 'rack/test'
require_relative '../lib/relation'
require 'pry'

def app
  Relation.new
end



describe Relation do
  include Rack::Test::Methods

  before(:each) do
    @relation = Redis.new(host: '127.0.0.1', port: 6379)
  end


  #Database Setup
  it 'posts a relation' do
    count = @relation.dbsize
    post 'relation/testkey/testvalue' do
      expect(@relation.get("testkey")).to eq('testvalue')
      expect(@relation.dbsize).to eq(count + 1)
      @relation.flushdb
    end
  end


end
