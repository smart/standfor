# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  layout 'default'
  
  def ssl_required?
     false and ENV['RAILS_ENV'] == 'production'
  end

  # render new.rhtml
  def new
    session[:return_to] = request.env['HTTP_REFERER'] || "/" if session[:return_to].blank? 
  	@context = 'login'
  end
  
  #this is the create function for session
  def create
    youser_authenticate
    #save_referrer_info and return false
  end

  def destroy
    #self.current_account.forget_me if logged_in?
    @current_account.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to("/")
  end
end
