class AddDefaultCountToCategory < ActiveRecord::Migration
  def change
    change_column :categories, :dishes_count, :integer, default: 0
  end
end
