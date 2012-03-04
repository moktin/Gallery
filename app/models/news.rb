class News < ActiveRecord::Base
  validates :start_at, :presence => true
  validate :start_at_inferior_to_end_at
  has_many :pictures

  def display_date
    display_date = "#{end_at ? I18n.t(:from) : I18n.t(:the)} #{I18n.l(start_at, :format => :date)}"
    display_date << " #{I18n.t(:to)} #{I18n.l(end_at, :format => :date)}" if end_at
    display_date
  end

  def images=(images)
    images.each do |image|
      pictures << Picture.new(:image => image)
    end
  end

  private
  def start_at_inferior_to_end_at
    errors.add(:end_at, I18n.t('news.need_to_be_superior_to_start_at')) if end_at and end_at < start_at
  end
end
