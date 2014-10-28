class LikesController < ApplicationController
  def create
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @like = @post.likes.new(user_id: current_user.id)
      unless @like.save
        flash[:errors] = @like.errors.full_messages
      end
    elsif params[:comment_id]
      @comment = Comment.find(params[:comment_id])
      @like = @comment.likes.new(user_id: current_user.id)
      unless @like.save
        flash[:errors] = @like.errors.full_messages
      end
    end

    redirect_to user_url(params[:user_id])
  end

  def destroy
    @like = Like.find(params[:id])
    unless @like.destroy
      flash[:errors] = @like.errors.full_messages
    end

    redirect_to user_url(params[:user_id])
  end
end
