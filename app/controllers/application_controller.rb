class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :redirect_logged_in_user
  helper_method :redirect_visitors

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_logged_in_user
    redirect_to dashboard_path if current_user
  end

  def redirect_visitors
    redirect_to sign_in_path unless current_user
  end
end
