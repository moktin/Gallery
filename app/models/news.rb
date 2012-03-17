class News < ActiveRecord::Base
  validates :start_at, :presence => true
  validate :start_at_inferior_to_end_at
  has_many :pictures, :dependent => :destroy

  default_scope order('created_at DESC')

  def display_date
    display_date = "// "
    if start_at and end_at
      if start_at.month == end_at.month and start_at.year == end_at.year
        display_date << "#{I18n.t('from_to')} #{I18n.l(start_at, :format => :really_short)} #{I18n.t('to')} #{I18n.l(end_at, :format => :short)}"
      elsif start_at.year == end_at.year
        display_date << "#{I18n.t('from_to')} #{I18n.l(start_at, :format => :some_short)} #{I18n.t('to')} #{I18n.l(end_at, :format => :short)}"
      else
        display_date << "#{I18n.t('from_to')} #{I18n.l(start_at, :format => :short)} #{I18n.t('to')} #{I18n.l(end_at, :format => :short)}"
      end
    elsif start_at
      display_date << "#{I18n.t('from')} #{I18n.l(start_at, :format => :short)}"
    end
    display_date << " //"
  end

  def images=(images)
    images.each do |image|
      pictures << Picture.new(:image => image)
    end
  end

  def main_picture
    pictures.first
  end

  def secondary_pictures
    main_picture ? pictures.where("pictures.id != ?", main_picture.id) : []
  end

  private
  def start_at_inferior_to_end_at
    errors.add(:end_at, I18n.t('news.need_to_be_superior_to_start_at')) if end_at and end_at < start_at
  end
end
