class Product < ApplicationRecord
    belongs_to :sub_category
  belongs_to :category
  has_many :image, class_name: 'Image', as: :imageable, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :cart_items
  self.per_page = 10

  def self.search(search)
    where(['product_name ILIKE ? OR category_name ILIKE ? OR sub_category_name ILIKE ?', "%#{search}%", "%#{search}%",
           "%#{search}%"])
  end
end
