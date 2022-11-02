class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.text :stripe_transaction_id
      t.text :payment_response
      
      t.timestamps
    end
  end
end
