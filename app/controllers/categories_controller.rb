class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    unless @category.has_children?
      redirect_to(category_pictures_path(@category))
    else
      @category_children = @category.categories.with_pictures
    end
  end
end
