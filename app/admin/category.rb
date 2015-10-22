ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column
    column :title
    column :dishes_count
    column :updated_at
    actions
  end

  filter :title
  filter :dishes_count
  filter :updated_at

  index do
    selectable_column
    id_column
    column :title

    column :updated_at
    actions
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
