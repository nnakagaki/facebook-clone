class PusherController < ApplicationController
	protect_from_forgery :except => :auth

	def auth
		if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id],{
      		user_id: current_user.id,
          user_info: {name: current_user.full_name}
      	})
      render :json => response
    else
      render :text => "Forbidden", :status => '403'
    end
	end
end
