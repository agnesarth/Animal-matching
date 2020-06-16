class MessagesChannel < ApplicationCable::Channel
  def subscribed
     stream_from 'messages'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create(content: data['message'], user_id: current_user.id)
    html = ApplicationController.render(partial: 'messages/message', locals: {
      message: message
    })
    ActionCable.server.broadcast 'messages', message: html
  end

end
