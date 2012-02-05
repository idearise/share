class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?

  
  private  
    
    def current_user  
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]  
    end  
    
    def user_signed_in?
      return 1 if current_user 
    end
    
    def logged_in?
      user_signed_in?
    end    
    
    def authenticate_user!
      if !current_user
        # Rails.logger.info(current_user.inspect)
        session[:requested_url] = request.fullpath
        flash[:error] = 'You need to sign in before accessing this page!'
        redirect_to signin_services_path
      end
    end
    
    def redirect_back
      if !session[:requested_url].nil?
        requested_url = session[:requested_url]
        session[:requested_url] = nil
        redirect_to requested_url
      else
        redirect_to root_url
      end
    end

end