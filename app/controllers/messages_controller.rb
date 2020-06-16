class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @messages = Message.last(4)
  end

 
end
