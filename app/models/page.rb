class Page < ActiveRecord::Base
  validates :name, :content, :presence => true
  validates :name, :uniqueness => true

  before_create :set_position
  after_destroy :clean_positions

  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope order('pages.position')

  scope :online, where(:online => true)

  def set_position
    self.position = self.class.count + 1
  end

  def clean_positions
    self.class.where("pages.position > ?", self.position).update_all("position = position - 1")
  end

  def self.update_positions(pages_positions)
    pages_positions.each_with_index { |page_id, index| update(page_id, :position => index + 1) }
  end
end
