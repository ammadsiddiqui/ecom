class CreateShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addresses do |t|
      t.string :name
      t.integer :number,  limit: 8
      t.integer :pin_code
      t.string :address
      t.boolean :default_address, default: false
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
