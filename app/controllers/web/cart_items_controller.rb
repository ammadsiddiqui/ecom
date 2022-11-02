class Web::CartItemsController < ApplicationController
    before_action :logged_in_user, only: %i[create destroy add_quantity reduce_quantity]

    def create
      chosen_product = Product.find(params[:product_id])
      add_items_to_cart(chosen_product)
      respond_to do |format|
        if @cart_item.save!
          format.html { redirect_back(fallback_location: @current_cart) }
          format.js
        else
          format.html { render :new, notice: 'Error adding product to basket!' }
        end
      end
    end

    def destroy
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      redirect_back(fallback_location: @current_cart)
    end

    def add_quantity
      @cart_item = CartItem.find(params[:id])
      @cart_item.quantity += 1
      @cart_item.save
      redirect_back(fallback_location: @current_cart)
    end

    def reduce_quantity
      @cart_item = CartItem.find(params[:id])
      if @cart_item.quantity > 1
        @cart_item.quantity -= 1
        @cart_item.save
        redirect_back(fallback_location: @current_cart)
      elsif @cart_item.quantity == 1
        destroy
      end
    end

    private

    def cart_item_params
      params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
    end

    def add_items_to_cart(chosen_product)
      if @current_cart.products.include?(chosen_product)
        @cart_item = @current_cart.cart_items.find_by(product_id: chosen_product)
        @cart_item.quantity += 1
      else
        @current_cart.update(user_id: @current_user.id) if @current_cart.user_id.blank?
        @cart_item = CartItem.new
        @cart_item.cart = @current_cart
        @cart_item.product = chosen_product
        @cart_item.quantity = 1
      end
    end
  
end
