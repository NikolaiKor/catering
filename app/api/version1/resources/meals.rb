require "grape"
module API
  module Version1
    class Meals < ::Grape::API
      version 'v1', using: :path

      resource :meals do
        before do
          user_by_token!
        end


        desc 'Categories list' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/group' do
          _group = @params[:group].to_i
          _dish = Dish.where('category_id = ?', _group)
          _business_lunch = BusinessLunch.where('category_id = ?', _group)
          {dish: _dish, business_lunch: _business_lunch}
        end

        desc 'Dishes by meal type' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        params do
          requires :type, type: String, desc: 'meal type'
        end
        get '/:type' do
          case @params[:type].downcase
            when 'dishes' then Dish.all
            when 'businesslunches' then BusinessLunch.all
          end
        end

        desc 'Dish by type and id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        params do
          requires :type, type: String, desc: 'meal type'
          requires :id, type: Integer, desc: 'meal id'
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