FactoryGirl.define do
  factory :sprint do
    title 'Active Sprint'
    state 1
    started_at {1.week.ago}
    finished_at {1.week.from_now}
  end
end