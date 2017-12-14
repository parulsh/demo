Rails.configuration.stripe = {
  :publishable_key => 'pk_test_6VEN3sDmT1C5AjkJdXHm4TMV',
  :secret_key => 'sk_test_ZjkKy8vrVwMO5l1GivbO5BWC'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
