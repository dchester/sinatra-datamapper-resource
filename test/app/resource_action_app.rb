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
  helpers Sinatra::DataMapper::Resource::Action

  post '/books' do
    @book = resource_action Book => :create
    @book.to_json
  end

  get '/books' do
    @books = resource_action Book => :list
    @books.to_json
  end

  get '/books/:id' do
    @book = resource_action Book => :read
    @book.to_json
  end

  patch '/books/:id' do
    @book = resource_action Book => :update
    @book.to_json
  end

  delete '/books/:id' do
    resource_action Book => :destroy
  end

  #run!

end
