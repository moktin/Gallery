class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    if @category.has_children_with_pictures?
      if @category.categories.with_pictures.count == 1
        redirect_to(category_pictures_path(@category.categories.first))
      else
        @category_children = @category.categories.with_pictures
      end
    else
      redirect_to(category_pictures_path(@category))
    end
  end
end
