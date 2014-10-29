module Api
  class UsersController < ApiController
    def index
      if current_user
        render json: {current_user: current_user.id, friends: current_user.friends}
      else
        render json: {}
      end
    end

    def show
      @user = User.find(params[:id])
      render :show
    end
  end
end
