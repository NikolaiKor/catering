class CreateBusinessLunches < ActiveRecord::Migration
  def change
    create_table :business_lunches do |t|
      t.string :title
      t.integer :price
      t.text :description
      t.integer :dish_ids, array: true, default: []
      t.timestamps null: false
    end
  end
end
