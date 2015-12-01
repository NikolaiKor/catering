class Meal < ActiveRecord::Base
  self.abstract_class = true

  has_one :category, as: :meal
  has_many :daily_rations, as: :meal
end
