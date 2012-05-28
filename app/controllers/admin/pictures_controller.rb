class Admin::PicturesController < AdminController
  respond_to :html, :js
  before_filter :set_referer, :only => [:edit]
  before_filter :fix_default_year_date, :only => [:update]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @pictures = @category.pictures
    else
      @pictures = Picture.page(params[:page]).per(24)
    end
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

  def update_positions
    category = Category.find(params[:category_id])
    category.update_pictures_positions(params[:picture])
    render :nothing => true
  end
end
