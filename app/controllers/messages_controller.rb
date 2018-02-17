class MessagesController < ApplicationController
  def new_message
    @user = User.find(params[:id])
    @users = User.except_user(current_user)   
    @chatroom = Chatroom.where("(user_id =? and sender_id= ?) OR (user_id =? and sender_id=?)",@user.id,current_user,current_user,@user.id).first
    @chatroom = @user.chatrooms.create(sender_id: current_user.id) unless @chatroom.present?
    mark_all_read(current_user)
    @message = Message.new
    @messages = @chatroom.messages.order("id DESC")
    render 'users/index'
  end   

  def create
    @chatroom = Chatroom.find(params[:message][:room_id])
    mark_all_read(current_user)
    message = @chatroom.messages.build(body: params[:message][:body],sender_id: current_user.id)
    if message.save
      redirect_to new_message_path(params["user_id"])
    end
  end

  def index
    @chatrooms = Chatroom.where("(user_id =?) OR (sender_id=?)",current_user,current_user)
  end

  def read_notification
    @notifications = Notification.where(recipient_id: current_user.id,read: false)
    @notifications.update_all(read: true)    
  end  

  private

  def mark_all_read(user)
    @chatroom.messages.unread(@chatroom.id,current_user.id).update_all(status: true)
  end
end
