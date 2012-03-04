class Admin::PicturesController < AdminController
  respond_to :html, :js

  def destroy
    @picture = Picture.find(params[:id]).destroy
  end
end
