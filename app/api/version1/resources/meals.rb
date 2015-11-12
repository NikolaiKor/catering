require "grape"
module API
  module Version1
    class Meals < ::Grape::API
      version 'v1', using: :path

      resource :meals do
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
          _dish = Dish.where('category_id = ?', _group)
          _business_lunch = BusinessLunch.where('category_id = ?', _group)
          {dish: _dish, business_lunch: _business_lunch}
        end

        desc 'Dish by id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/:type/:id' do
          case @params[:type].downcase
            when 'dish' then Dish.find(@params[:id])
            when 'businesslunch' then BusinessLunch.find(@params[:id])
          end
        end
      end
    end
  end
end