class News < ActiveRecord::Base
  validates :start_at, :presence => true
  validate :start_at_inferior_to_end_at
  has_many :pictures, :dependent => :destroy

  default_scope order('created_at DESC')

  def images=(images)
    images.each { |image| pictures << Picture.new(:image => image) }
  end

  def main_picture
    pictures.first
  end

  def secondary_pictures
    main_picture ? pictures.where("pictures.id != ?", main_picture.id) : []
  end

  private
  def start_at_inferior_to_end_at
    errors.add(:end_at, I18n.t('news.need_to_be_superior_to_start_at')) if end_at and start_at and end_at < start_at
  end
end
