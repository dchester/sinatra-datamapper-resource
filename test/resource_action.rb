require_relative 'app/resource_action_app.rb'
require 'test/unit'
require 'rack/test'
require_relative 'module/crud'

class Tester < Test::Unit::TestCase
  include Rack::Test::Methods
  include CRUD

  def app
    TestAPI
  end

end
