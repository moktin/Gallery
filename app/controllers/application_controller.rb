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

end
