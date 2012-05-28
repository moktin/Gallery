class Admin::PicturesCollectionsController < AdminController
  before_filter :set_referer, :only => [:new]
  before_filter :fix_default_year_date, :only => [:update]

  def new
    @pictures_collection = PicturesCollection.new(:category_ids => [params[:category_id].to_i])
  end

  def create
    @pictures = Picture.create_collection(params[:pictures_collection], params[:pictures_collection][:pictures])
    redirect_to(get_referer)
  end

end
