Rails.configuration.stripe = {
  :publishable_key => 'pk_test_ULbh5pQDlxbGzmBiCR9adQ0e',
  :secret_key => 'sk_test_SS6OtFn6X6NuPy3lIlZmmAfL'

}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
