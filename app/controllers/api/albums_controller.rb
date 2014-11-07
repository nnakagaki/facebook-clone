module Api
  class AlbumsController < ApiController
    def create
      @album = current_user.photos.new(album_params)
      unless @album.save
        render json: @album.errors, status: :unprocessable_entity
      end

      render json: @album
    end

    def index
      render json: current_user.albums
    end

    private
    def album_params
      require(:album).permit(:title)
    end
  end
end
