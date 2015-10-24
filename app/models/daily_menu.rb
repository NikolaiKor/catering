class DailyMenu < ActiveRecord::Base
  belongs_to :dishes
  has_many :business_lunches

  validates :day_number, :presence => true
  validates :max_total, :presence => true
  validates :dish_ids, :presence => true
end
