require 'sinatra/base'
require 'data_mapper'
require_relative '../../lib/sinatra/datamapper_resource'

class Book
    include DataMapper::Resource

    property :id, Serial
    property :title, String, :required => true
    property :isbn, String
end

DataMapper.setup :default, 'sqlite::memory:'
DataMapper.auto_migrate!

class TestAPI < Sinatra::Base
  register Sinatra::DataMapper::Resource
  resource Book, '/books'
  #run!
end
