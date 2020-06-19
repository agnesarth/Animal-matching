class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @new_chatroom = Chatroom.new
    @chatroom = current_user.chatrooms.build(title: params[:title])
    @chatroom.users << current_user
    @chatroom.users << User.find(params[:chatroom_users])

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

end
