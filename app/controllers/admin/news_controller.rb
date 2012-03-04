class Admin::NewsController < AdminController

  before_filter :find_news, :except => [:index, :new, :create]

  def index
    @news = News.page(params[:page]).per(10)
  end

  def new
    @news = News.new
  end

  def show
  end

  def create
    @news = News.new(params[:news])
    if @news.save
      redirect_to admin_news_index_path, :notice => t('news.create.success')
    else
      render :new
    end
  end

  def update
    if @news.update_attributes(params[:news])
      redirect_to admin_news_index_path, :notice =>  t('news.update.success')
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to admin_news_index_path, :notice => t('news.destroy.success')
  end

  private
  def find_news
    @news = News.find(params[:id])
  end


end
