class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  include ApplicationHelper
  helper_method :current_user


  def current_user
    current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  private

  def set_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      cart.present? ? (@current_cart = cart) : (session[:cart_id] = nil)
    end
    return unless session[:cart_id].nil?

    @current_cart = Cart.create!(user_id: nil)
    session[:cart_id] = @current_cart.id
  end

  def logged_in_user
    return if current_user.present?

    store_location
    flash[:danger] = 'please login in.'
    redirect_to new_web_session_path
  end
end
