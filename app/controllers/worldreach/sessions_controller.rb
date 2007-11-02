# This controller handles the login/logout function of the site.  
class Worldreach::SessionsController < ApplicationController
  layout 'worldreach/default'
  # Be sure to include YouserSystem in Application Controller instead
  include YouserSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
  
  # render new.rhtml
  def new
  end
  
  #this is the create function for session
  def create
    local_user_authentication
  end

  def destroy
    self.current_account.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to worldreach_home_path
  end
end
