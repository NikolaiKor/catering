class FixDishIdsFieldDailyMenu < ActiveRecord::Migration
  def change
    remove_column :daily_menus, :dish_ids
    add_column :daily_menus, :dish_ids, :integer, array: true, default: []
  end
end
