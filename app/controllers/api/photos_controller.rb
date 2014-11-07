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
      params.require(:photo).permit(:album_id, :description, :url)
    end

    def album_params
      params.require(:photo).permit(:title)
    end

    def save_photo
      @photo = current_user.photos.new(photo_params)
      if @photo.save
        render json: @photo
      else
        render json: @photo.errors, status: :unprocessable_entity
      end
    end
  end
end
