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
      @user = User.includes(wall_posts: [:author, :likes, :comments]).find(params[:id])
      render :show
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def search
      render json: User.search_by_full_name(params[:query]).first(8)
    end

    private
    def user_params
      params.require(:user).permit(:profile_pic_url, :profile_pic_mini_url, :cover_pic_url)
    end
  end
end
