class PagesController < ApplicationController
  def show
    @page = Page.online.find(params[:id])
  end
end
