class Order < ApplicationRecord
  enum status: {Waiting: 0, Approved: 1, Declined: 2}

  belongs_to :user 
  has_many :order_foods
  after_create :send_notification

  def send_notification
    begin
    	UserMailer.send_order_email(user_id).deliver_now
      phone_number = user.phone_number
      if phone_number.present?
        @client = Twilio::REST::Client.new
        @client.messages.create(
          from: '+15207624206',
          to: phone_number,
          body: "Your Order has been successfully created"
        )
      end
    rescue 
    end
  end
  
end
