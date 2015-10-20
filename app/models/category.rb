class Category < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 45}
end
