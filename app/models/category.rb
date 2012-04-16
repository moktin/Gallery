class Category < ActiveRecord::Base
  belongs_to :category, :foreign_key => 'category_id'

  has_many :categories, :dependent => :destroy, :class_name => 'Category'
  has_many :category_pictures
  has_many :pictures, :through => :category_pictures

  extend FriendlyId
  friendly_id :name, use: :slugged

  translates :name
  validates :name_fr, :name_en, :presence => true, :uniqueness => { :scope => :category_id}



  before_create :set_position
  after_destroy :clean_positions

  default_scope order("categories.position")

  scope :roots, where(:category_id => nil)
  scope :children, where("category_id IS NOT NULL")
  scope :childless, lambda { where(!children.blank? ? ['categories.id NOT IN(?)', children.collect(&:category_id)] : nil) }
  scope :with_pictures, includes(:pictures).where('pictures.id IS NOT NULL')
  scope :brothers_of, lambda { |category|
    where(:category_id => category.category_id).where(category.id ? ["categories.id != ?", category.id] : "categories.id IS NOT NULL")
  }

  def has_children?
    self.class.where(:category_id => self.id).any?
  end

  def has_children_with_pictures?
    self.class.with_pictures.where(:category_id => self.id).any?
  end

  def brothers
    self.class.brothers_of(self)
  end

  def set_position
    self.position = brothers.count + 1
  end

  def clean_positions
    brothers.where("categories.position > ?", self.position).update_all("position = position - 1")
  end

  def self.update_positions(categories_positions)
    categories_positions.each_with_index { |category_id, index| update(category_id, :position => index + 1) }
  end

  def update_pictures_positions(pictures_positions)
    pictures_positions.each_with_index do |picture_id, index|
      self.category_pictures.where(:picture_id => picture_id).first.update_attribute(:position, index + 1)
    end
  end

end
