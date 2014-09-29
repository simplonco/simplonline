class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :authenticate_user, :track
  before_filter :remote_can_access, except: [:index, :show]

  private

  def authenticate_user
    redirect_to welcome_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def track
    Log.create_for(current_user) if current_user
  end

  def remote_can_access
    redirect_to root_path if current_user.remote?
  end
end
