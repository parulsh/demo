class StripeMerchantService

  def initialize
    @api_key = ENV['STRIPE_SECRET_KEY']
    @client_id = ENV['STRIPE_CLIENT_ID']
    @options = {site: 'https://connect.stripe.com', authorize_url: '/oauth/authorize', token_url: '/oauth/token', raise_errors: false}
  end

  def get_approve_url
    params = {
      scope: 'read_write',
      response_type: 'code',
      redirect_uri: get_address
    }
    client.auth_code.authorize_url(params)  
  end

  def get_token(code)
    response = client.auth_code.get_token(code, params: {scope: 'read_write'})
    return { error: response.params["error_description"] } if response.params["error"].present?
    { stripe_user_id: response.params["stripe_user_id"], stripe_secret_key: response.token,  stripe_publishable_key: response.params["stripe_publishable_key"]}
  end

  def client
    OAuth2::Client.new(@client_id, @api_key, @options)
  end

  private
    def get_address
      "#{ENV['DOMAIN_URL']}/payment_setting/update_stripe_merchant_details"
    end
end
