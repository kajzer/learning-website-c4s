Rails.configuration.stripe = {
  :publishable_key => 'pk_test_32OSbVCQKylGc94zscGE3IlA',
  :secret_key      => 'sk_test_jdjbGdA3n81fNULpOl8t12O5'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]