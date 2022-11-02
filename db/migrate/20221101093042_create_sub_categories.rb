class CreateSubCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_categories do |t|
      t.string :sub_category_name, null: false, default: ''
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
