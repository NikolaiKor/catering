class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :title
      t.integer :price
      t.text :description
      t.float :price
      t.timestamps null: false
    end
  end
end
