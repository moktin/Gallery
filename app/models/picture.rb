class Picture < ActiveRecord::Base
  belongs_to :news

  belongs_to :support
  belongs_to :collection
  belongs_to :location
  belongs_to :dimension
  belongs_to :technic
  belongs_to :material

  has_many :category_pictures
  has_many :categories, :through => :category_pictures

  has_attached_file :image,
  :styles => {
    :thumb => "182x70>",
    :small => "260x100>",
    :news => "220x320",
    :normal => "650x500>"
  }

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => %w( image/jpeg image/png image/gif image/pjpeg image/x-png )

  def self.create_collection(params, pictures)
    params.delete(:pictures)
    error_number = 0
    new_pictures = []
    pictures.each { |picture| new_pictures << Picture.create(params.merge(:image => picture))} if pictures
    new_pictures
  end

end
