module Api
  class NotificationsController < ApiController
    def index
      render :index
    end

    def update
      @notification = Notification.find(params[:id])
      if @notification.update(notification_params)
        render json: @notification
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    private
    def notification_params
      params.require(:notification).permit(:seen)
    end
  end
end
