class LanguagesController < ApplicationController

  def update
    session[:language] = params[:id]
    redirect_to :back
  end
end
