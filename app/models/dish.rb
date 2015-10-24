class Dish < Meal
  self.table_name = 'dishes'

  after_create :inc_dishes_count
  after_destroy :dec_dishes_count
  after_update :check_category

  belongs_to :category

  validates :title, presence: true, length: {maximum: 45}
  validates :price, presence: true
  validates :category_id, presence: true

  private
  def inc_dishes_count(chaiging_category = category)
    chaiging_category.dishes_count +=1
    chaiging_category.save
  end

  def dec_dishes_count(chaiging_category = category)
    chaiging_category.dishes_count -=1
    chaiging_category.save
  end

  def check_category
     _changes = changes
    print changes.inspect
    if _changes.include? :category_id
      _change_id =_changes['category_id']
      dec_dishes_count(Category.find(_change_id[0]))
      inc_dishes_count(category)
    end
  end
end
