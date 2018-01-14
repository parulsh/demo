class CreatePaymentSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_settings do |t|
      t.integer :user_id
      t.string :stripe_user_id
      t.boolean :is_stripe_connected
      t.string :stripe_user_id
      t.string :stripe_secret_key
      t.string :stripe_publishable_key

      t.timestamps
    end
  end
end
