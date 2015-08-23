class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method 'current_user', 'logged_in?'

  def debug_message message
    puts '********************************************'
    puts "******* #{message} ************"
    puts '********************************************'
  end

  def current_user
    if session[:user_id]
      @current_user ||= AdminUser.find(session[:user_id])
    else
      false
    end
  end

  def logged_in?
    unless current_user
      flash['notice'] = 'Please login.'
      redirect_to controller: 'session', action: 'login'
      return false
    else
      true
    end
  end

end
