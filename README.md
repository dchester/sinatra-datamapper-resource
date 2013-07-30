# Sinatra DataMapper Resource Helpers

Build RESTful resources around DataMapper models.

## Getting Started

Build a datamapper model, and then add its surrounding API with `resource`:

```ruby
require 'sinatra'
require 'data_mapper'
require 'sinatra/datamapper_resource'

# define a datamapper model and initialize the schema

class Book
    include DataMapper::Resource

    property :id, Serial
    property :title, String, :required => true
    property :isbn, String
end

DataMapper.setup :default, 'sqlite::memory:'
DataMapper.auto_migrate!

# add surrounding routes and controllers
resource Book, '/books'
```

As an alternative, if you want to have more control or be more explicit, you can piece things together yourself with `resource_action`:

```ruby
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

This is equivalent to calling `resource` as above.

