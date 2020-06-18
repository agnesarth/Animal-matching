class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = current_user.chatrooms.build(title: chatroom_params[:title])
    @chatroom.users << current_user
    @chatroom.users << chatroom_params[:user]

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
      params.require(:chatroom).permit(:title, :user)
    end
end
