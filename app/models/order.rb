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
          from: '+15202146012',
          to: phone_number,
          body: "Thank you for ordering with Panza! Your ordered is being processed and it will be ready shortly."
        )
      end
    rescue 
    end
  end
  
end
