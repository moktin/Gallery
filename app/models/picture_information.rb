class PictureInformation < ActiveRecord::Base
  validates :name_fr, :presence => true, :uniqueness => { :scope => :type}
end
