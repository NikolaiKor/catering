FactoryGirl.define do
  factory :daily_ration do
    price 50
    quantity 2
    person_id 1
    daily_menu_id 1
    sprint_id 1
    meal_id 1
    meal_type 'Dish'
  end
end