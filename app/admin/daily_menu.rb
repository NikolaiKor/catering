ActiveAdmin.register DailyMenu do

  permit_params :day_number, :max_total, :dish_ids

  index do
    selectable_column
    column :day_number
    column :max_total
    column(:dish_ids) do |menu|
      menu.dish_ids.each do |id|
        _dish = Dish.find(id)
        link_to "#{_dish.title} ", admin_dish_path(_dish)
      end
    end
    actions
  end

  filter :day_number
  filter :max_total
  filter :dish_ids, collection: Dish.all, include_blank: false


  form do |f|
    f.inputs "Dish details" do
      f.input :day_number
      f.input :max_total
      f.input :dish_ids
    end
    f.actions
  end

  # show do |menu|
  #   panel "Daily menu details" do
  #     table_for(menu.dishes) do |t|
  #       t.column(:title)
  #       t.column(:price)
  #       t.column(:category)
  #     end
  #   end
  # end
end
