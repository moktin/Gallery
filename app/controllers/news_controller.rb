class NewsController < ApplicationController
  def index
    @news = News.page(params[:page]).per(20)
  end
end
