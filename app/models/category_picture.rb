class CategoryPicture < ActiveRecord::Base
  belongs_to :category
  belongs_to :picture

  before_create :set_position
  after_destroy :clean_positions

  default_scope order('category_pictures.position')
  def set_position
    self.position = category.category_pictures.count + 1
  end

  def clean_positions
    category.category_pictures.where("category_pictures.position > ?", self.position).update_all("position = position - 1")
  end

end
