class PicturesController < ApplicationController

  def show
    @news = News.find(params[:news_id]) if params[:news_id]
    if @news
      @picture = @news.pictures.find(params[:id])
      respond_to do |format|
        format.js { render 'replace_main_image'}
      end
    end
  end

  def index
    @category = Category.find(params[:category_id])
    @pictures = @category.pictures
  end
end
