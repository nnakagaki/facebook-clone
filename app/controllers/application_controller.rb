class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @u ||= User.find_by_session_token(session[:session_token])
  end

  def current_user_likes
    @l ||= Like.where(user_id: current_user.id)
  end

  def current_user_check
    unless current_user
      redirect_to new_user_url
    end
  end

  helper_method :current_user, :current_user_likes
end
