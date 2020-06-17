class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = current_user.chatrooms.build(chatroom_params)
    if @chatroom.save
      flash[:success] = 'Chat (ou chien) roulette ajoutée!'
      redirect_to chatrooms_path
    else
      render 'new'
    end
  end
  
  def show
    @chatroom = Chatroom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  private
    def chatroom_params
      params.require(:chatroom).permit(:title)
    end
end
