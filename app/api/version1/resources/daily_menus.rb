require "grape"
module API
  module Version1
    class DailyMenus < ::Grape::API
      version 'v1', using: :path

      resource :daily_menus do
        before do
          user_by_token!
        end

        desc 'All daily menus' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/' do
          DailyMenu.order(:day_number)
        end

        desc 'Daily menu by id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/:id' do
          DailyMenu.find(@params[:id])
        end

        desc 'Daily menu by id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/:id/dishes' do
          _menu = DailyMenu.find(@params[:id])
          Dish.where('id IN(?)', _menu.dish_ids)
        end
      end
    end
  end
end
