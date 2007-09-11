# This controller handles the login/logout function of the site.  
class <%= controller_class_name %>Controller < ApplicationController
  # Be sure to include YouserSystem in Application Controller instead
  include YouserSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # render new.rhtml
  def new
  end
  
  #this is the create function for session
  def create
    case determine_authenticator
      <% unless options[:skip_open_id] %>
        when "OpenId"
        open_id_authentication
      <% end %>
      <% unless options[:skip_facebook] %>
      when "Facebook"
        facebook_authentication
      <% end %>
      <% unless options[:skip_local_user] %>
      when "LocalUser"
        local_user_authentication
      <% end %>
      else
      normal_create
    end  
  end
  
  def normal_create
    throw "Implement me in this controller!"
  end  

  def destroy
    self.current_<%= file_name %>.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
