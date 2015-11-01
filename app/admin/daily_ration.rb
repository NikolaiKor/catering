ActiveAdmin.register DailyRation do
  actions :index, :show

  permit_params :price, :quantity, :person_id, :daily_menu_id, :sprint_id, :dish_id, :meal_id, :meal_type

  index do
    selectable_column
    column :price
    column :quantity
    column(:person) do |ration|
      _person = ration.user
      link_to("##{_person.id} #{_person.name}", admin_user_path(_person))
    end
    column :sprint do |ration|
      _sprint = ration.sprint
      link_to(_sprint.title.to_s + ' ' +
                  I18n.l(_sprint.started_at, format: :short) + '-' +
                  I18n.l(_sprint.finished_at, format: :short), admin_sprint_path(ration.sprint))
    end
    column(:meal) do |ration|
      _meal = ration.meal
      auto_link _meal
      #link_to "#{_meal.title} ", "#{admin_root_path}/#{_meal.class.to_s.downcase.pluralize}/#{_meal.id}"
    end
    actions
  end

  filter :price
  filter :quantity
  filter :person_id
  filter :sprint, collection: Sprint.all, include_blank: false
  filter :meal_id
  filter :meal_type
end
