class Admin::PicturesController < AdminController
  respond_to :html, :js
  before_filter :set_referer, :only => [:edit]

  def index
    @category = Category.where(:id => params[:category_id]).first if params[:category_id]
    @pictures = (@category ? @category.pictures : Picture).page(params[:page]).per(24)
  end

  def destroy
    @picture = Picture.find(params[:id]).destroy
    redirect_to(get_referer)
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.update_attributes(params[:picture])
    redirect_to(get_referer)
  end
end
