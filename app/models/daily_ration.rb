class DailyRation < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :daily_menu
  belongs_to :meal, polymorphic: true

  validates :price, :presence => true
  validates :quantity, :presence => true
  validates :person_id, :presence => true
  validates :daily_menu_id, :presence => true
  validates :sprint_id, :presence => true
  validates :meal_id, :presence => true
  validates :meal_type, :presence => true
end
