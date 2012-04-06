class NewsController < ApplicationController
  def index
    @news = NewsDecorator.decorate(News.page(params[:page]).per(20))
  end
end
