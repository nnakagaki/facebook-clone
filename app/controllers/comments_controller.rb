class CommentsController < ApplicationController
	def create
		@comment = current_user.comments.new(comment_params)
		unless @comment.save
			flash[:errors] = @comment.errors.full_messages
		end

		redirect_to user_url(params[:current_user_page_id])
	end

	private
	def comment_params
		params.require(:comment).permit(:description, :post_id)
	end
end
