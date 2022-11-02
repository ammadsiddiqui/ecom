class Web::UsersController < ApplicationController
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  
  def new
   @user = User.new
   @category = Category.all

  end    

  def create
    	 user = User.new(user_params)
          if user.save
            cookies.signed[:user_id] = user.id
            redirect_to  web_users_path, notice: "User created successfully"
         else 
          flash[:error] = "Email already exist."
          redirect_to new_web_user_path
      end
  end

  def index
     add_before_signin(session[:forwarding_url].split('/')[-1].split('=')[-1].to_i) if session[:forwarding_url].present?
    if params[:search].present?
      @products = Product.search(params[:search])
       @products = @products.paginate(page: params[:page]).order('created_at DESC')
    else
      @category = Category.all
    @products = Product.paginate(page: params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
    end
  end

  def product_details
    @a = Product.find_by(id: params[:id])&.sub_category_id
    @sub_categories = SubCategory.find_by(id: @a)
    @products_details = @sub_categories&.products&.last(4)
    @product = Product.find_by(id: params[:id])
    @all_sub_category = @product&.category&.sub_categories
  end

  def product_category
    @products = Product.find_by(sub_category_id: params[:id])
    @sub_category = SubCategory.find_by(id: params[:id])
    @all_sub_category = @sub_category&.category&.sub_categories
    @products = @sub_category.products
  end

  def check_email
    @user = User.pluck(:email)
      if @user.include?(params[:user][:email])
        render json: false
      else
        render json: true
      end
  end

  def check_email_login
    @user = User.pluck(:email)
    if @user.include?(params[:user][:email])
      render json: true
    else
      render json: false
    end
  end

 
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:phone_no, :address)
  end

  def add_before_signin(id)
    chosen_product = Product.find(id)
    if @current_cart.products.include?(chosen_product)
       @cart_item = @current_cart.cart_items.find_by(product_id: chosen_product)
       @cart_item.quantity += 1
     else
      @current_cart.update(user_id: current_user.id) if @current_cart.user_id.blank?
      @cart_item = CartItem.new
      @cart_item.cart = @current_cart
      @cart_item.product = chosen_product
      @cart_item.quantity = 1
      @cart_item.save!
      session.delete(:forwarding_url)
    end
  end
  
end
