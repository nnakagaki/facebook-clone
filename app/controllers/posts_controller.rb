class PostsController < ApplicationController
	def create
		@post = current_user.authored_posts.new(post_params)
		unless @post.save
			flash[:errors] = @post.errors.full_messages
		end

    @post.follows.create(user_id: current_user.id)
    @post.follows.create(user_id: params[:userwall_id])

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
