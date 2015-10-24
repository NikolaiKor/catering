ActiveAdmin.register Dish do
  permit_params :title, :price, :description, :category_id

  index do
    selectable_column
    column :title
    column(:category, :sortable => :sort_order) {|dish| link_to "#{dish.category.title} ", admin_category_path(dish.category)}
    column :price
    column :updated_at
    actions
  end

  filter :category
  filter :title
  filter :price
  filter :updated_at

  form do |f|
    f.inputs "Dish details" do
      f.input :title
      f.input :price
      f.input :description
      f.input :category, collection: Category.all, include_blank: false
    end
    f.actions
  end
end
