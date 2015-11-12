class AddCategoryIdToBusinessLunch < ActiveRecord::Migration
  def change
    add_column :business_lunches, :category_id, :integer
  end
end
