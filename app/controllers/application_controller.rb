class ApplicationController < ActionController::Base
  add_flash_types(:danger)

  private 

  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def current_user 
  #   @current_user ||= User.find(params[:id]) if params[:id]
  # end

  helper_method :current_user

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: "You need to be signed in!"
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to movies_url, alert: "You need to be an admin to do that!"
    end
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
end
