class Dish < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, length: {maximum: 45}
  validates :price, presence: true
end
