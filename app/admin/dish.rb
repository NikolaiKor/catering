ActiveAdmin.register Dish do
  permit_params :title, :price, :description, :category_id

  index do
    selectable_column
    column :title
    column('category') {|dish| link_to "#{dish.category.title} ", admin_category_path(dish.category)}
    column :price
    column :updated_at
    actions
  end

  filter :category
  filter :title
  filter :price
  filter :updated_at

  form do |f|
    f.inputs "Bisuness lunch details" do
      f.input :title
      f.input :price
      f.input :description
      f.input :category, collection: Category.all, include_blank: false
    end
    f.actions
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
