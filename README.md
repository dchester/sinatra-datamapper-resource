# Sinatra DataMapper Resource Helpers

Build RESTful resources around DataMapper models.

## Getting Started

Build a datamapper model and then associate routes with actions via the `resource_action` helper

```ruby
require 'sinatra'
require 'data_mapper'
require 'sinatra/datamapper_resource'

class Book
    include DataMapper::Resource

    property :id, Serial
    property :title, String, :required => true
    property :isbn, String
end

DataMapper.setup :default, 'sqlite::memory:'
DataMapper.auto_migrate!

get '/books' do
  @book = resource_action Book => :list
  @book.to_json
end

get '/books/:id' do
  @books = resource_action Book => :read
  @books.to_json
end

post '/books' do
  @book = resource_action Book => :create
  @book.to_json
end

patch '/books/:id' do
  @book = resource_action Book => :update
  @book.to_json
end

delete '/books/:id' do
 resource_action Book => :destroy
end
```


