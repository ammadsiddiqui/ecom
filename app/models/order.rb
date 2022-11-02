class Order < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    belongs_to :user
    has_one :shipping_address, dependent: :destroy
  
    def sub_total
      sum = 0
      cart_items.each do |cart_item|
        sum += cart_item.total_price
      end
      sum
    end
  
    def self.make_payment(token, total_price)
      Rails.logger.debug "-----------token------#{token.inspect}---"
      Rails.logger.debug "-----------price------#{total_price.inspect}---"
      begin
        Rails.logger.debug '-----begin--------'
        response = Stripe::Charge.create(
          amount: total_price,
          currency: 'inr',
          description: 'Example Charge',
          capture: false,
          source: token
        )
        response.capture
        Rails.logger.debug "-------response--------#{response.inspect}------------"
        [true, response]
      rescue StandardError => e
        [false, e.message]
      end
    end
  
    def self.update_address(name, number, pin_code, address, user_id, order_id)
      order = ShippingAddress.new(name: name, number: number, pin_code: pin_code, address: address, user_id: user_id,
                                  order_id: order_id)
      order.save!
    end
  
end
