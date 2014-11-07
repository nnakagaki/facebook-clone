module Api
  class PhotosController < ApiController
    def create
      if current_user.albums.where(title: params[:photo][:title]).length == 0
        @album = current_user.albums.new(album_params)
        if @album.save
          params[:photo][:album_id] = @album.id
          save_photo
        else
          render json: @album.errors, status: :unprocessable_entity
        end
      else
        params[:photo][:album_id] = current_user.albums.where(title: params[:photo][:title])[0].id
        save_photo
      end
    end

    def index
      render json: current_user.photos
    end

    private
    def photo_params
      params.require(:photo).permit(:album_id, :url)
    end

    def album_params
      params.require(:photo).permit(:title)
    end

    def save_photo
      @photo = current_user.photos.new(photo_params)
      post = Post.new(author_id: current_user.id, userwall_id: current_user.id, latitude: params[:photo][:latitude], longitude: params[:photo][:longitude], description: params[:photo][:description])
      if post.save
        @photo.post_id = post.id
        if @photo.save
          post.update(photo_id: @photo.id)
          render json: @photo
        else
          render json: @photo.errors, status: :unprocessable_entity
        end
      else
        render json: post.errors, status: :unprocessable_entity
      end
    end
  end
end
