class Admin::SessionController < Admin::BaseController
  layout 'adminlte'

  def new
    # render :layout => false
  end

  def create
  	user = User.find_by(email: params[:email])
    if (user && user.authenticate(params[:password]))
    	session[:admin_id] = user.id
      flash[:notice] = "You are successfully logged In."
      redirect_to  admin_homes_path
    else
      redirect_to new_admin_session_path
      flash[:error] = "Invalid Email or Password"
    end
  end


  
end
