class FriendRequestsController < ApplicationController
  before_action :current_user_check

  def create
    @request = current_user.friend_requests_to_be_accepted.new(requested_id: params[:requested_id])
    unless @request.save
      flash[:errors] = @request.errors.full_messages
    end

    redirect_to user_url(params[:requested_id])
  end
end
