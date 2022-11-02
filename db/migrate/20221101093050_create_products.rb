class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :category_name, null: false, default: ''
      t.string :sub_category_name, null: false, default: ''
      t.string :store_name, null: false, default: ''
      t.string :product_name, null: false, default: ''
      t.string :description,  null: false, default: ''
      t.string :color, null: false, default: ''
      t.integer :price, default: 0, null: false

      t.references :sub_category, foreign_key: true
      t.references :category, froegin_key: true
      t.references :store, froegin_key: true
      t.timestamps
    end
  end
end
