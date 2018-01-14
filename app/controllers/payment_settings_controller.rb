class PaymentSettingsController < ApplicationController
  before_action :find_or_create_payment_setting
  protect_from_forgery except: :process_stripe_webhook
  
  def show
  end

  def connect_with_stripe
    merchant_service = StripeMerchantService.new
    approve_url = merchant_service.get_approve_url
    redirect_to approve_url
  end

  def update_stripe_merchant_details
    if params[:error].blank?
      merchant_service = StripeMerchantService.new
      response = merchant_service.get_token(params[:code])
      if response[:error].present?
        flash[:error] = response[:error]
      else
        flash[:success] = "Your stripe account has been sucessfully connected." 
        @payment_setting.update_attributes(stripe_user_id: response[:stripe_user_id], stripe_secret_key: response[:stripe_secret_key],
                                           stripe_publishable_key: response[:stripe_publishable_key], is_stripe_connected: true )
      end
    else
      flash[:error] = params[:error_description]
    end
    redirect_to payment_setting_path
  end

  private
    def find_or_create_payment_setting
      @payment_setting = PaymentSetting.find_or_create_by(user_id: current_user.id)
    end

end
