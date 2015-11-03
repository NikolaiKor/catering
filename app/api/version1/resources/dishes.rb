require "grape"
module API
  module Version1
    class Dishes < ::Grape::API
      version 'v1', using: :path

      resource :dishes do
        before do
          user_by_token!
        end

        desc 'Dishes by id array'
        get '/group' do
          _group = Array.wrap(@params[:group].keys).map(&:to_i)
          Dish.where('id = ANY(ARRAY[?])', _group)
        end

        desc 'Dish by id'
        get '/:id' do
          Dish.find(@params[:id])
        end
      end
    end
  end
end
