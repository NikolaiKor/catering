require "grape"
module API
  module Version1
    class DailyMenus < ::Grape::API
      version 'v1', using: :path

      resource :daily_menus do
        before do
          user_by_token!
        end

        desc 'All daily menus'
        get '/' do
          DailyMenu.order(:day_number)
        end

        desc 'Daily menu by id'
        get '/:id' do
          DailyMenu.find(@params[:id])
        end
      end
    end
  end
end
