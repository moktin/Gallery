class Picture < ActiveRecord::Base
  belongs_to :news

  has_attached_file :image,
  :styles => {
    :thumb => "182x70>",
    :small  => "260x100>",
    :normal => "650x500>"
  }

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => %w( image/jpeg image/png image/gif image/pjpeg image/x-png )

end
