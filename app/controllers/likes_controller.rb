class LikesController < ApplicationController
  before_action :current_user_check

  def create
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @like = @post.likes.new(user_id: current_user.id)
      if @like.save
        @post.followers.each do |user|
          unless current_user == user
            user.notifications.create(author_id: current_user.id,
                                      post_id: @post.id,
                                      notifyable_id: @like.id,
                                      notifyable_type: "Like")
          end
        end
      else
        flash[:errors] = @like.errors.full_messages
      end
    elsif params[:comment_id]
      @comment = Comment.find(params[:comment_id])
      @like = @comment.likes.new(user_id: current_user.id)
      if @like.save
        @post = @comment.post
        @post.followers.each do |user|
          unless current_user == user
            user.notifications.create(author_id: current_user.id,
                                      post_id: @post.id,
                                      notifyable_id: @like.id,
                                      notifyable_type: "Like")
          end
        end
      else
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
