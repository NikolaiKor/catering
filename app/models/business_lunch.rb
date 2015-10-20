class BusinessLunch < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 45}
  validates :price
end
