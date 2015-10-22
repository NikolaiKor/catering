class AddDishesCountToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :dishes_count, :integer
  end
end
