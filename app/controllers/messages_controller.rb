class MessagesController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!, only: [:index]

  def index
    @messages = Message.last(4)
  end

 
end
=======


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
>>>>>>> 552335cc13edfa9e8f3d019836c44a24d0b6bb9d
