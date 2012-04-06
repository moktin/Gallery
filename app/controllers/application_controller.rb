class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_adminship
    unless (current_user and current_user.admin?)
      flash[:alert] = t('administrations.access_denied')
      redirect_to root_path
      false
    else
      true
    end
  end


  def set_referer
    session[:referer] = back_url
  end

  def get_referer
    session.delete(:referer)
  end

  def back_url
    request.env["HTTP_REFERER"]
  end
end
