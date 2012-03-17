class Admin::PicturesCollectionsController < AdminController

  def new
    @pictures_collection = PicturesCollection.new(:category_ids => [params[:category_id].to_i])
  end

  def create
    @pictures = Picture.create_collection(params[:pictures_collection], params[:pictures_collection][:pictures])
    redirect_to(admin_pictures_path)
  end

end
