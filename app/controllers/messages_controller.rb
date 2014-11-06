class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def past_messages
    @messages = Message.where(chat_id: params[:chat_id])
    render json: @messages
  end

  private
  def message_params
    params.require(:message).permit(:message, :user_id, :chat_id)
  end
end
