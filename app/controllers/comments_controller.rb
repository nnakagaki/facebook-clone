class CommentsController < ApplicationController
  before_action :current_user_check

	def create
		@comment = current_user.comments.new(comment_params)
		if @comment.save
      @post = Post.find(params[:comment][:post_id])
      @post.followers.each do |user|
        unless current_user == user
          user.notifications.create(author_id: current_user.id,
                                    post_id: params[:comment][:post_id],
                                    notifyable_id: @comment.id,
                                    notifyable_type: "Comment")
        end
      end
      current_user.follows.create(post_id: params[:comment][:post_id])
    else
			flash[:errors] = @comment.errors.full_messages
		end

		redirect_to user_url(params[:current_user_page_id])
	end

  def destroy
    @comment = Comment.find(params[:id])
    unless @comment.destroy
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_to user_url(params[:user_id])
  end

	private
	def comment_params
		params.require(:comment).permit(:description, :post_id)
	end
end
