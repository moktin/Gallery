class PicturesCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :description, :dimensions, :technic, :materials, :year,  :pictures, :categories, :category_ids, :year

  def persisted?
    false
  end
end
