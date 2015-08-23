class SessionController < ApplicationController
  before_action 'logged_in?', only: [:index]

  layout 'admin'

  def index
  end

  def login
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      user = AdminUser.where(username: params[:username]).first
      if user
        user = user.authenticate(params[:password])
      end
    end
    if user
      session[:user_id] = user.id
      session[:username] = user.username
      flash['notice'] = 'you are now logged in'
      redirect_to action: 'index'
    else
      flash['notice'] = 'invalid username/password combination.'
      redirect_to action: 'login'
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    redirect_to action: 'login'
  end
end
