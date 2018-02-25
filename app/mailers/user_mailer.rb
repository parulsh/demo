class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def send_order_email(user_id)
    @user = User.find user_id
    mail(to: @user.email, subject: 'Order Confirmed')
  end

  def notify_seller(user_id, order_id)
  	@user = User.find user_id
  	@order = Order.find order_id
  	mail(to: @user.email, subject: 'Order Received')
  end
end
