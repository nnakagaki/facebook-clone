class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      session[:session_token] = @user.reset_session_token
      redirect_to "#" + user_path(@user.id)
    else
      flash.now[:errors] = ["wrong email/password combination"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
