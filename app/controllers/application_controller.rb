class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
    helper_method :current_user, :logged_in? 
    #these helper methods ara available to other controller by default but they are not availbele for the view, 
    #so with this statement, rails will make the following methods available to the view
    
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id] 
      #return this user if session[:user_id] that is stored in our session hash if so then find the user in our database and display it, 
      # the @current_user is handy if the user already exist and we do not want the user id keep heiting the database every time 
    end
    
    def logged_in?
      !!current_user # this !! will convert @current_user into a boolean in order to check if the user is loged in
    end
    
    def require_user
      if !logged_in? # if the user is not log in, he will be redirected to root page
        respond_to do |format|
          format.html { redirect_to root_path, notice: "You must be logged in to perform that action"}
        end
      end
    end
end
#Source : http://rails-4-0.railstutorial.org/book/sign_in_out and video

