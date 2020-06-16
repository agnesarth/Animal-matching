class MessagesController < ApplicationController

  def index
    @messages = Message.last(4)
  end

 
end
