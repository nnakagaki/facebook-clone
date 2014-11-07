module Api
  class FriendsController < ApiController
    def create
      @friendship = Friend.new(friend_id: current_user.id, friended_id: params[:requestor_id])
      unless @friendship.save
        render json: @friendship.errors, state: :unprocessable_entity
      end

      FriendRequest.find(params[:request_id]).destroy

      render json: @friendship
    end
  end
end
