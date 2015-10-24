class AddPolymorphicToMeal < ActiveRecord::Migration
  def change
    remove_column :daily_rations, :dish_id
    change_table :daily_rations do |t|
      t.references :meal, polymorphic: true, index: true
    end

  end
end
