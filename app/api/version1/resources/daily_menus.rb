require "grape"
module API
  module Version1
    class DailyMenus < ::Grape::API
      version 'v1', using: :path

      resource :daily_menus do
        desc "All daily menus"
        get '/' do
          DailyMenu.order(:day_number)
        end
      end
    end
  end
end
