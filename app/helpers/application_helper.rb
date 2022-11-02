module ApplicationHelper
    def log_in(user)
        session[:user_id] = user.id
      end
    
     
      # Returns true if the user is logged in, false otherwise.
      def logged_in?
        !current_user.nil?
      end
    
      # Forgets a persistent session.
      def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
      end
    
      # Logs out the current user.
      def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
      end
    
      # Redirects to stored location (or to the default).
      def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
      end
    
      # Stores the URL trying to be accessed.
      def store_location
        session[:forwarding_url] = request.original_url #if request.get?
      end
end
