module Api
  class FriendRequestsController < ApiController
    def create
      @request = current_user.friend_requests_to_be_accepted.new(requested_id: params[:requested_id])
      unless @request.save
        render json: @request.errors, status: :unprocessable_entity
      end

      Pusher.trigger("private-friendship-#{ params[:requested_id] }", "friendship", {})

      render json: @request
    end

    def index
      render :index
    end
  end
end
