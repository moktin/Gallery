class PictureDecorator < ApplicationDecorator
  decorates :picture

  def name_and_year
    h.content_tag(:div, [self.name.blank? ? "Sans titre" : "#{self.name}", self.year ? I18n.l(self.year, :format => :year) : nil].reject{|a| a.blank?}.join(', '))
  end

  def materials_technic_dimensions
    if not self.material.blank? or not self.dimension.blank? or not self.technic.blank?
      h.content_tag(:div, [self.material.try(:name), self.technic.try(:name), self.dimension.try(:name)].reject{|a| a.blank?}.join(', '))
    end
  end

end
