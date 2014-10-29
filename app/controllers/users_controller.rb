class UsersController < ApplicationController
  def static
    render :static
  end

  def index
    if current_user
      render json: {current_user: current_user, friends: current_user.friends}
    else
      render json: {}
    end
  end

  def new
    if current_user
      redirect_to "#" + user_path(current_user)
    else
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.reset_session_token
      redirect_to "#" + user_path(@user.id)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @user}
    end
  end

  private
  def user_params
    params[:user][:first_name].capitalize!
    params[:user][:last_name].capitalize!
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
