class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def send_order_email(user_id)
    @user = User.find user_id
    mail(to: @user.email, subject: 'Order Confirmed')
  end
end
