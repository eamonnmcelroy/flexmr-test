class UserSessionsController < ApplicationController

  skip_before_action :ensure_user_logged_in, only: [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(create_params)
    if @user_session.save
      flash[:success] = 'You are now logged in'
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = 'You have successfully logged out'
    redirect_to root_path
  end

  private

  def create_params
    params.require(:user_session).permit(:email, :password)
  end

end
