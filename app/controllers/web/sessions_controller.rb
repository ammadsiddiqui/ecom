class Web::SessionsController < ApplicationController
    def new
        @category = Category.all
    end

    def create
            user = User.find_by(email: params[:email])
           if (user&.present? and user&.authenticate(params[:password]))
                     cookies.signed[:user_id] = user.id
                   
                   session[:user_id] = user.id
            flash[:notice] = "You are successfully logged In."
            redirect_to  web_users_path
          
          else
             redirect_to  root_path
             flash[:error] = "Invalid Email or Password"
          end
    end

    def destroy
        cookies.signed[:user_id] = nil if cookies.signed[:user_id].present?
        redirect_to '/'
      end

end
