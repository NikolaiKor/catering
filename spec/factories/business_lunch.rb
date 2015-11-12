FactoryGirl.define do
  factory :business_lunch do
    title 'Student lunch'
    price 50
    category_id 1
    dish_ids '{1,2,3}'
  end
end