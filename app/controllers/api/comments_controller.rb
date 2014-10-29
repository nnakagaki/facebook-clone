module Api
  class CommentsController < ApiController
    def show
      @comment = Comment.find(params[:id])
      render json: @comment
    end

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
        render json: @comment
      else
  			render json: @comment.errors, status: :unprocessable_entity
  		end
  	end

    def destroy
      @comment = Comment.find(params[:id])
      unless @comment.destroy
        render json: @comment.errors, status: :unprocessable_entity
      end

      render json: @comment
    end

  	private
  	def comment_params
  		params.require(:comment).permit(:description, :post_id)
  	end
  end
end
