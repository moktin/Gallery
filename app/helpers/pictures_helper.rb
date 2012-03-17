module PicturesHelper

  def name_and_year(picture)
    if not picture.name.blank? or not picture.year.blank?
      content_tag(:div, [picture.name.blank? ? nil : "\"#{picture.name}\"", picture.year ? l(picture.year, :format => :year) : nil].reject{|a| a.blank?}.join(', '))
    end
  end

  def materials_technic_dimensions(picture)
    if not picture.materials.blank? or not picture.dimensions.blank? or not picture.technic.blank?
      content_tag(:div, [picture.materials, picture.technic, picture.dimensions].reject{|a| a.blank?}.join(', '))
    end
  end

end
