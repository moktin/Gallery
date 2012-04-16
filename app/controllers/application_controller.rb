class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_language

  helper_method :current_locale, :other_locale

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


  def other_locale
    current_locale == :fr ? :en : :fr
  end

  def current_locale
    I18n.locale.to_sym
  end

  private
  def set_user_language
    I18n.locale = params[:locale] || session[:language] || I18n.default_locale
  end
end
