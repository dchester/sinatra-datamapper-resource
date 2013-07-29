# Sinatra DataMapper + REST

Build RESTful resources around DataMapper models.

```ruby
require 'sinatra'
require 'sinatra/json'

get '/books' do
  json resource_action Book => :list
end

get '/books/:id' do
  json resource_action Book => :read
end

post '/books' do
  resource_action Book => :create
end

patch '/books/:id' do
  resource_action Book => :update
end

delete '/books/:id' do
 resource_action Book => :destroy
end
```

