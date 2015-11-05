require "grape"
module API
  module Version1
    class Dishes < ::Grape::API
      version 'v1', using: :path

      resource :dishes do
        before do
          user_by_token!
        end

        desc 'Dishes by id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        params do
          requires :group, type: Integer, desc: 'group id'
        end
        get '/group' do
          _group = @params[:group].to_i
          Dish.where('category_id = ?', _group)
        end

        desc 'Dish by id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/:id' do
          Dish.find(@params[:id]).to_json
        end
      end
    end
  end
end