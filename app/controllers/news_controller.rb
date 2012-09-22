class NewsController < ApplicationController
  def index
    @news = NewsDecorator.decorate(News.published.with_translation.page(params[:page]).per(20))
  end
end
