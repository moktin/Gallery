class Admin::CategoriesController < AdminController
  respond_to :html

  def index
    @categories = Category.roots
  end

  def new
    @category = Category.new(:category_id => params[:category_id])
  end

  def create
    @category = Category.new(params[:category])
    @category.save
    respond_with(@category) do |format|
      format.html do
        if @category.valid?
          redirect_to admin_categories_path
        else
          @categories = Category.roots
          render @category.category ? :new : :index
        end
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    respond_with([:admin, @category])
  end

  def update_positions
    params[:category].each_with_index do |category_id, index|
      Category.update(category_id, :position => index + 1)
    end
    render :nothing => true
  end

end
