require_relative 'api'
require 'test/unit'
require 'rack/test'

class Tester < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestAPI
  end

  def test_create
    post '/books', '{"title": "trials of being jimz", "isbn": "0234234"}', { "CONTENT_TYPE" => 'application/json' }

    assert_equal last_response.status, 201, "status is 201 created"
    assert_equal last_response.header["Content-Type"], "application/json;charset=utf-8", "application/json content type"

    body = JSON.parse last_response.body
    assert_equal body["id"], 1
    assert_equal body["title"], "trials of being jimz"

    delete '/books/1'
    assert_equal last_response.status, 204, "status is 204 no content"
  end

  def test_read
    post '/books', '{"title": "trials of being jimz", "isbn": "0234234"}', { "CONTENT_TYPE" => 'application/json' }

    assert_equal last_response.status, 201, "status is 201 created"
    body = JSON.parse last_response.body
    id = body["id"].to_s

    get '/books/' + id

    assert_equal body["title"], "trials of being jimz"

    delete '/books/' + id
    assert_equal last_response.status, 204, "status is 204 no content"
  end

  def test_list
    post '/books', 
      '{"title": "trials of being jimz", "isbn": "0234234"}',
      { "CONTENT_TYPE" => 'application/json' }

    assert_equal last_response.status, 201, "status is 201 created"

    post '/books', 
      '{"title": "trials of being artz", "isbn": "0234235"}',
      { "CONTENT_TYPE" => 'application/json' }

    assert_equal last_response.status, 201, "status is 201 created"

    get '/books'
    assert_equal last_response.status, 200, "status is 200 ok"
    assert_equal last_response.header["Content-Type"], "application/json;charset=utf-8", "application/json content type"

    body = JSON.parse last_response.body
    assert_equal body.length, 2, "response has a single element"
    assert_equal body[0]["title"], "trials of being jimz", "0th element has correct title"

    delete '/books/' + body[0]['id'].to_s
    assert_equal last_response.status, 204, "status is 204 no content"

    delete '/books/' + body[1]['id'].to_s
    assert_equal last_response.status, 204, "status is 204 no content"
  end

  def test_update
    post '/books', 
     '{"title": "trials of being jimz", "isbn": "0234234"}',
     { "CONTENT_TYPE" => 'application/json' }

    assert_equal last_response.status, 201, "status is 201 created"

    body = JSON.parse last_response.body
    id = body["id"].to_s

    patch '/books/' + id,
      '{"isbn": "44302"}', 
      { "CONTENT_TYPE" => 'application/json' }

    assert_equal last_response.status, 200, "status is 200 ok"

    puts "__ID__"
    puts id

    get '/books/' + id

    assert_equal last_response.status, 200, "status is 200 ok"
    body = JSON.parse last_response.body

    puts "BODY"
    puts last_response.body

    puts "____ISBN____"
    puts body["isbn"]
    puts "44302"

    assert_equal body["isbn"].to_s, "44302", "isbn is updated"
    
  end
end
