class PicturesCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  attr_accessor :description, :dimensions, :technic, :materials, :year,  :pictures, :categories, :category_ids

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
