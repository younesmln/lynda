class UsersController < ApplicationController
  layout 'admin'
  before_action 'get_object', only: [:edit, :update, :destroy]
  before_action 'logged_in?'

  def index
    @admin_users = AdminUser.all.sorted
  end

  def new
    @admin = AdminUser.new
  end

  def create
    @admin = AdminUser.new(admin_params)
    if @admin.save
      flash['notice'] = 'admin created successfully'
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @admin.update_attributes(admin_params)
      flash['notice'] = 'admin updated successfully'
      redirect_to action: 'index'
    else
      render 'edit'
    end

  end

  def delete

  end

  def destroy
    @admin.destroy
    flash['notice'] = 'admin destroyed successfully'
    redirect_to action: 'index'
  end

  private

    def get_object
      begin
        @admin = AdminUser.find(params[:id])
      rescue
        redirect_to :back
      end
    end

    def admin_params
      params.require(:admin_user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end
end
