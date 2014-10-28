class PostsController < ApplicationController
	def create
		@post = current_user.authored_posts.new(post_params)
		unless @post.save
			flash[:errors] = @post.errors.full_messages
		end

		redirect_to user_url(post_params[:userwall_id])
	end

	private
	def post_params
		params.require(:post).permit(:description, :userwall_id)
	end
end
