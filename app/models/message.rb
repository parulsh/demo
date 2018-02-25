class Message < ApplicationRecord
	belongs_to :user ,:optional=>true
	belongs_to :sender, :class_name => "User", :foreign_key => "sender_id" 
	belongs_to :chatroom ,:optional=>true
	belongs_to :chat_room ,:class_name => "Chatroom", :foreign_key => "chat_room_id" 
	after_create_commit { MessageBroadcastJob.perform_later(self) }
	scope :unread,->(chatroom_id, user_id) {where("(chat_room_id = ? and user_id = ? and status = ?)",chatroom_id, user_id, false)}
	after_create :mark_as_read

	def mark_as_read
		chat_room.messages.where(sender_id: user_id, user_id: sender_id, status: false).update_all(status: true)
	end

	def timestamp
	  created_at.strftime('%H:%M:%S %d %B %Y')
	end
end
