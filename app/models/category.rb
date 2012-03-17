class Category < ActiveRecord::Base
  belongs_to :category, :foreign_key => 'category_id'
  has_many :categories, :dependent => :destroy, :class_name => 'Category'
  has_many :category_pictures
  has_many :pictures, :through => :category_pictures

  validates :name, :presence => true, :uniqueness => { :scope => :category_id}

  scope :roots, where(:category_id => nil)
  scope :children, where("category_id IS NOT NULL")
  scope :childless, lambda { where('id NOT IN(?)', children.collect(&:category_id))}

  scope :with_pictures, includes(:pictures).where('pictures.id IS NOT NULL')

  def has_children?
    self.class.where(:category_id => self.id).any?
  end

  def has_children_with_pictures?
    self.class.with_pictures.where(:category_id => self.id).any?
  end
end
