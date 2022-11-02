class CartItem < ApplicationRecord
    belongs_to :product
  belongs_to :cart

  def total_price
    if valid_quantity_and_price?
      quantity.to_s.to_i * product.price.to_s.to_i
    else
      0.0
    end
  end

  def valid_quantity_and_price?
    !quantity.to_s.strip.empty? && !product.price.to_s.strip.empty?
  end
end
