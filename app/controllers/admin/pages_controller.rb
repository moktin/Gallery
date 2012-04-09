class Admin::PagesController < AdminController
  respond_to :html

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      respond_with([:admin, @page])
    else
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      respond_with([:admin, @page])
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id]).destroy
    respond_with([:admin, @page])
  end

  def update_positions
    Page.update_positions(params[:page])
    render :nothing => true
  end
end
