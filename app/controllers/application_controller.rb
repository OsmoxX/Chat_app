class ApplicationController < ActionController::Base
  before_action :update_last_seen
  helper_method :current_user, :logged_in?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to perform this action"
      redirect_to login_path
    end
  end

  private
  def update_last_seen
    if logged_in?
      current_user.update_column(:last_seen_at, Time.current)
    end
  end

end
