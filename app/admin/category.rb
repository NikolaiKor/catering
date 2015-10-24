ActiveAdmin.register Category do
  config.sort_order = "sort_order_asc"

  permit_params :title, :sort_order

  index do
    selectable_column
    column :title
    column :dishes_count
    column :sort_order
    column :updated_at
    actions
  end

  filter :title
  filter :dishes_count
  filter :updated_at


  form do |f|
    f.inputs "Category details" do
      f.input :title
      f.input :sort_order
    end
    f.actions
  end
end
