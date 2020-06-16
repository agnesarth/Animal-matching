class MessagesChannel < ApplicationCable::Channel
  def subscribed
     stream_from 'messages'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = ApplicationController.render(partial: 'messages/message', locals: {message: data['message']} )
    ActionCable.server.broadcast 'messages', message: message
  end

end
