require "grape"
module API
  module Version1
    class Categories < ::Grape::API
      version 'v1', using: :path

      resource :categories do
        before do
          user_by_token!
        end

        desc 'Categories list' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        get '/' do
          _categories =  Category.includes(:dishes).all
          _result = []
          _categories.each do |category|
            _result << {name: category.title, sort_order: category.sort_order, dishes: category.dishes}
          end
          _result
        end

        desc 'Dishes in category by category id' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        params do
          requires :id, type: Integer, desc: 'group id'
        end
        get '/:id' do
          _dish = Dish.where('category_id = ?', @params[:id].to_i)
          _business_lunch = BusinessLunch.where('category_id = ?', @params[:id].to_i)
          {dish: _dish, business_lunch: _business_lunch}
        end
      end
    end
  end
end