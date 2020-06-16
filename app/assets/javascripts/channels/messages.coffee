
git addApp.messages = App.cable.subscriptions.create "MessagesChannel",

  

  connected: ->
    $(document).on 'keypress', '#message', (event) =>
      if event.keyCode is 13
        @speak(event.target.value)
        event.target.value = ""
        event.preventDefault()

    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append(data.message)
    

    # Called when there's incoming data on the websocket for this channel

  speak: (message) ->
    @perform 'speak', {message: message}

  