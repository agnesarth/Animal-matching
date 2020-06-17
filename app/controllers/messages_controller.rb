class MessagesController < ApplicationController


  def create
    @message = Message.create(message_params)
    room_id = @message.chatroom_id
    redirect_to chatroom_path(room_id)
  end


  private
  def message_params
    params.require(:message).permit(:chatroom_id, :body, :user_id)
  end
end