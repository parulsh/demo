class Message < ApplicationRecord
	belongs_to :user ,:optional=>true
	belongs_to :sender, :class_name => "User", :foreign_key => "sender_id" 
	belongs_to :chatroom ,:optional=>true
	after_create_commit { MessageBroadcastJob.perform_later(self) }
	scope :unread,->(chatroom_id, user_id) {where("(chat_room_id = ? and user_id = ? and status = ?)",chatroom_id, user_id, false)}

	def timestamp
	  created_at.strftime('%H:%M:%S %d %B %Y')
	end
end
