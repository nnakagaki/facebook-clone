class FriendController < ApplicationController
  before_action :current_user_check

  def create
    @friendship = Friend.new(friend_id: current_user.id, friended_id: params[:requestor_id])
    unless @friendship.save
      flash[:errors] = @friendship.errors.full_messages
    end

    FriendRequest.find(params[:request_id]).destroy

    redirect_to user_url(params[:requestor_id])
  end
end
