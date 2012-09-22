class News < ActiveRecord::Base
  validate :start_at_inferior_to_end_at
  has_many :pictures, :dependent => :destroy

  translates :title, :content

  default_scope order('created_at DESC')
  scope :published, where(:published => true)

  def self.with_translation(locale = I18n.locale)
    other_locale = locale.to_s == 'fr' ? 'en' : 'fr'
    where("(title_#{locale} IS NULL AND title_#{other_locale} IS NULL AND content_#{locale} IS NULL AND content_#{other_locale} IS NULL) OR title_#{locale} IS NOT NULL OR content_#{locale} IS NOT NULL")
  end

  def images=(images)
    images.each { |image| pictures << Picture.new(:image => image) }
  end

  def main_picture
    pictures.first
  end

  def secondary_pictures
    main_picture ? pictures.where("pictures.id != ?", main_picture.id) : []
  end

  def has_translation?(locale = I18n.locale)
    other_locale = locale.to_s == 'fr' ? 'en' : 'fr'
    (self["title_#{locale}"] or self["content_#{locale}"]) or (self["title_#{locale}"].nil? and self["title_#{other_locale}"].nil? and self["content_#{locale}"].nil? and self["content_#{other_locale}"].nil?)
  end

  private
  def start_at_inferior_to_end_at
    errors.add(:end_at, I18n.t('news.need_to_be_superior_to_start_at')) if end_at and start_at and end_at < start_at
  end
end
