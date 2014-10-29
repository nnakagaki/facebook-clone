module Api
  class LikesController < ApiController
    def show
      @like = Like.find(params[:id])
      render json: @like
    end

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
          render json: @like
        else
          render json: @like.errors, status: :unprocessable_entity
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
          render json: @like
        else
          render json: @like.errors, status: :unprocessable_entity
        end
      end
    end

    def destroy
      @like = Like.find(params[:id])
      unless @like.destroy
        render json: @like.errors, status: :unprocessable_entity
      end

      render json: @like
    end
  end
end
