# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  # def subscribed
  #   # stream_from "some_channel"
  #   stream_from 'messages'
  # end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end

  # def send_message(data)
  # 	message = Message.create!(body: data['message'], chat_room_id: data['chat_room_id'],sender_id: current_user.id)
  # end
end