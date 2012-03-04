class Category < ActiveRecord::Base
  belongs_to :category
  has_many :categories, :dependent => :destroy
  has_many :category_pictures
  has_many :pictures, :through => :category_pictures

  validates :name, :presence => true, :uniqueness => { :scope => :category_id}

  scope :roots, where(:category_id => nil)
end
