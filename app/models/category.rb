class Category < ActiveRecord::Base
  # has_many :meals, polymorphic: true
  has_many :dishes
  validates :title, presence: true, length: {maximum: 45}
end
