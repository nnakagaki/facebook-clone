class PusherController < ApplicationController
	protect_from_forgery :except => :auth

	def auth
		if current_user
      channel = params[:channel_name]
      if channel[0..15] == "private-chatRoom"
        chatter_ids = channel[17..channel.length-1].split("-")
        if chatter_ids.include?(current_user.id.to_s)
          if_auth_passed
        else
          render :text => "Forbidden", :status => '403'
        end
      elsif channel[0..19] == "private-notification"
        not_id = channel[21..channel.length-1]
        if not_id == current_user.id.to_s
          if_auth_passed
        else
          render :text => "Forbidden", :status => '403'
        end
      elsif channel[0..17] == "private-friendship"
				friendship_id = channel[19..channel.length-1]
				if friendship_id == current_user.id.to_s
					if_auth_passed
				else
					render :text => "Forbidden", :status => '403'
				end
			else
        if_auth_passed
      end
    else
      render :text => "Forbidden", :status => '403'
    end
	end

  private
  def if_auth_passed
    if current_user.profile_pic_mini_url
      pic = current_user.profile_pic_mini_url
    else
      pic = ActionController::Base.helpers.image_url("default_profile_pic.jpg")
    end
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id],{
        user_id: current_user.id,
        user_info: {
          name: current_user.full_name,
          pic: pic
        }
      })
    render :json => response
  end

end
