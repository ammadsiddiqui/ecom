class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :store_name, null: false, default: ''

      t.timestamps
    end
  end
end
