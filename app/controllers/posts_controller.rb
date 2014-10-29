class PostsController < ApplicationController
  before_action :current_user_check

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
    else
			flash[:errors] = @post.errors.full_messages
		end

		redirect_to user_url(post_params[:userwall_id])
	end

  def destroy
    @post = Post.find(params[:id])
    unless @post.destroy
      flash[:errors] = @post.errors.full_messages
    end

    redirect_to user_url(params[:user_id])
  end

	private
	def post_params
		params.require(:post).permit(:description, :userwall_id)
	end
end
