class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  has_many :messages ,:class_name => "Message", :foreign_key => "chat_room_id" 
  scope :find_chatroom,->(user,current_user) {where("(user_id=? and sender_id =?) OR (user_id=? and sender_id =?)",user.id,current_user.id,current_user.id,user.id)}

  def get_conversation_user(current_user)
    "Conversation with #{get_receiver_name(current_user)}" rescue "Conversation"
  end

  def get_receiver_name(current_user)
  	(user_id == current_user.id ? sender.fullname : user.fullname) rescue nil
  end

  def last_message
  	messages.last
  end

  def sender_or_receiver_id(current_user)
  	(user_id == current_user.id ? sender_id : user_id) rescue current_user.try(:id)
  end
end
