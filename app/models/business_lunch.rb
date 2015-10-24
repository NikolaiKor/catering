class BusinessLunch < Meal
  self.table_name = 'business_lunches'

  validates :title, presence: true, length: {maximum: 45}
end
