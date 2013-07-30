require 'sinatra/base'
require 'json'
require_relative 'datamapper_resource_action'

module Sinatra
  module DataMapper
    module Resource

      Sinatra::Base::helpers Sinatra::DataMapper::Resource::Action

      def resource(model, base_path)

        post base_path do
          @item = resource_action model => :create
          @item.to_json
        end

        get base_path do
          @item = resource_action model => :list
          @item.to_json
        end

        get base_path + '/:id' do
          @item = resource_action model => :read
          @item.to_json
        end

        patch base_path + '/:id' do
          @item = resource_action model => :update
          @item.to_json
        end

        delete base_path + '/:id' do
          @item = resource_action model => :destroy
        end

      end

    end
  end

  register DataMapper::Resource
end

