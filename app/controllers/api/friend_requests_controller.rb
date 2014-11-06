module Api
  class FriendRequestsController < ApplicationController
    before_action :current_user_check, except: :index

    def create
      @request = current_user.friend_requests_to_be_accepted.new(requested_id: params[:requested_id])
      unless @request.save
        render json: @request.errors, status: :unprocessable_entity
      end

      render json: @request
    end

    def index
      render :index
    end
  end
end
