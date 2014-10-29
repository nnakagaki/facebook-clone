module Api
  class PostsController < ApiController
    def show
      @post = Post.find(params[:id])
      render json: @post
    end

  	def create
  		@post = current_user.authored_posts.new(post_params)
  		if @post.save
        @post.follows.create(user_id: params[:post][:userwall_id])
        unless params[:post][:userwall_id].to_i == current_user.id
          @user = User.find(params[:post][:userwall_id])
          @user.notifications.create(author_id: current_user.id,
                                     post_id: @post.id,
                                     notifyable_id: @post.id,
                                     notifyable_type: "Post")
        end
        @post.follows.create(user_id: current_user.id)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
  		end
  	end

    def destroy
      @post = Post.find(params[:id])
      unless @post.destroy
        render json: @post.errors, status: :unprocessable_entity
      end

      render json: @post
    end

  	private
  	def post_params
  		params.require(:post).permit(:description, :userwall_id)
  	end
  end
end
