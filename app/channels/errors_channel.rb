class ErrorsChannel < ApplicationCable::Channel
  def subscribed
     stream_from "errors_#{current_user}"
  end

end
