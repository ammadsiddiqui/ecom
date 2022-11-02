Rails.application.routes.draw do
  namespace :admin do
    get 'session/new'
    resources :sessions do
      collection do 
        post :forget_password
        post :update_password 
      end
    end
  end
  namespace :web do
    get 'users/index'
    post 'cart_items/:id/add' => 'cart_items#add_quantity', as: 'cart_item_add'
    post 'cart_items/:id/reduce' => 'cart_items#reduce_quantity', as: 'cart_item_reduce'
    delete 'cart_items/:id' => 'cart_items#destroy'
    post 'cart_items' => 'cart_items#create'
    get 'cart_items/:id' => 'cart_items#show', as: 'cart_item'
    get 'carts/:id' => 'carts#show', as: 'cart'
    delete 'carts/:id' => 'carts#destroy'
    resources :orders
    resources :users do
      collection do
        get :check_email
        get :check_email_login
      end
      member do
        get :product_details
        get :product_category
      end
    end
    resources :sessions do
      collection do
       post :forget_password
     end
   end
  end


  get '/admin' => 'admin/session#new'
  root 'web/users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
