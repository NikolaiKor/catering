ActiveAdmin.register BusinessLunch do
  permit_params :title, :price, :description, :dish_ids

  index do
    selectable_column
    column :title
    column :price
    column :description
    column :dish_ids
    actions
  end

  filter :title
  filter :price
  filter :description
  filter :dish_ids

  form do |f|
    f.inputs "Bisuness lunch details" do
      f.input :title
      f.input :price
      f.input :dish_ids
      f.input :description
    end
  end
end
