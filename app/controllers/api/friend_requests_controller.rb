module Api
  class FriendRequestsController < ApiController
    before_action :current_user_check

    def create
      @request = current_user.friend_requests_to_be_accepted.new(requested_id: params[:requested_id])
      unless @request.save
        render json: @request.errors, status: :unprocessable_entity
      end

      render json: @request
    end
  end
end
