class CreateBankDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_details do |t|
      t.bigint :account_number
      t.string :holder_name
      t.string :special_code
      t.string :account_type
      t.boolean :default_address, default: false
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
