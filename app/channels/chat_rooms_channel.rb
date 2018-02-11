# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params["chat_room_id"]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
  	Message.create!(body: data['message'], chat_room_id: data['chat_room_id'],sender_id: current_user.id,user_id: data["user_id"])
  end
end