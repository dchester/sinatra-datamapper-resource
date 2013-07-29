require 'sinatra/base'
require 'json'

module Sinatra
  module ResourceAction

      def resource_action(model_action)
        content_type "application/json"
        model, action = model_action.flatten
        self.send(action, model)
      end

      def read(model)
        if @item = model.get(params[:id])
          return @item
        else
          halt 404, { error: "not found" }.to_json
        end
      end

      def list(model)
        @items = model.all
        return body @items
      end

      def create(model)
        body = JSON.parse request.body.read
        @item = model.new(body)

        if @item.valid?
          if @item.save
            status 201
            href = request.path + "/" + @item.id.to_s # an assumption
            headers "Location" => request.path
            return @item
          else
            return status 500
          end
        else
          status 400
          return { errors: @item.errors.to_hash }
        end
      end

      def update(model)
        if @item = model.get(params[:id])
          @item
        else
          status 404
          return { error: "not found" }
        end

        body = JSON.parse request.body.read
        @item.attributes = body

        if @item.valid?
          if @item.save
            return status 200
          else
            return status 500
          end
        else
          status 400
          return { errors: @item.errors.to_hash }
        end
      end

      def destroy(model)
        if @item = model.get(params[:id])
          if @item.destroy
            return status 204
          else 
            return status 500
          end
        else
          status 404
          return { error: "not found" }
        end
      end

  end
  helpers ResourceAction
end
