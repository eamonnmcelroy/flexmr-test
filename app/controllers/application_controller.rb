class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :ensure_user_logged_in

  helper_method :current_user_session, :current_user

  def ensure_user_logged_in
    unless current_user
      flash[:alert] = 'You cannot access this area without being logged in'
      redirect_to login_path
    end
  end

  def ensure_user_is_admin
    unless current_user and current_user.admin?
      flash[:alert] = 'You cannot access this area'
      redirect_to root_path
    end
  end

  def current_user_session
    return @current_user_session if @current_user_session
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if @current_user
    if current_user_session
      @current_user = current_user_session.user
    else
      nil
    end
  end

end
