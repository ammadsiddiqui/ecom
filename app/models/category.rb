class Category < ApplicationRecord
    has_many :sub_categories, autosave: true, dependent: :destroy
  has_many :product, dependent: :destroy
end
