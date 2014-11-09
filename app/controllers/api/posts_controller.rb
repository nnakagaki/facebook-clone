module Api
  class PostsController < ApiController
    def show
      @post = Post.find(params[:id])
      render :show
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
          Pusher.trigger("private-notification-#{@user.id}", "notification", {})
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

    def embed
      link_info = LinkThumbnailer.generate(params[:match])
      info = ""
      info += "<div class='buzzfeed'>"
      info += "<a href='#{link_info.url}' target='_blank'></a>"

      unless link_info.images.length == 0
        info += "<div class='picture' style='background-image: url(#{link_info.images[0].src})'></div>"
      end

      link_info.title.gsub!(/"/, "&#34;")
      link_info.title.gsub!(/</, "&#60;")
      link_info.title.gsub!(/>/, "&#62;")
      link_info.description.gsub!(/"/, "&#34;")
      link_info.description.gsub!(/</, "&#60;")
      link_info.description.gsub!(/>/, "&#62;")

      info += "<div class='title'>#{link_info.title}</div>"
      info += "<div class='description'>#{link_info.description}</div>"
      info += "</div>"

      render json: {info: info}
    end

  	private
  	def post_params
  		params.require(:post).permit(:description, :userwall_id, :longitude, :latitude, :embed)
  	end
  end
end
