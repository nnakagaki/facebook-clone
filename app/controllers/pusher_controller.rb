class PusherController < ApplicationController
	protect_from_forgery :except => :auth

	def auth
		if current_user
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
    else
      render :text => "Forbidden", :status => '403'
    end
	end
end
