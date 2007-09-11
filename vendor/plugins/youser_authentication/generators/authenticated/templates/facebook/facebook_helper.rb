module FacebookHelper

  def using_facebook?(facebook = params[:facebook])
    params[:facebook] ? true : false
  end
  
  def facebook_authentication
    require_facebook_login
    if fbsession.is_valid?
      finish_facebook_login
    end
  end
  
  def finish_facebook_login
    unless @<%= file_name %> = <%= class_name %>.find_by_youser(fbsession.session_user_id, "Facebook")
      @<%= file_name %> = <%= class_name %>.new(:create_auth_token => fbsession.session_user_id, :create_authenticator => "Facebook")
      assign_facebook_attributes(fbsession.session_user_id, fbsession)
    end
    self.current_<%= file_name %> = @<%= file_name %>
    successful_login
  end
  
  private
  # registration is a hash containing the valid sreg keys given above
    # use this to map them to fields of your user model
    def assign_facebook_attributes(fb_user_id, fb_session)
#      { 
#        :login  => 'nickname', 
#        :email  => 'email', 
#        :name   => 'fullname' 
#      }.each do |model_attribute, registration_attribute|
#        unless registration[registration_attribute].blank?
          #@user.send("#{model_attribute}=", registration[registration_attribute])
 #       end
   #   end
      # CHOOSE - Uncomment to clean up logins as desired for application; 
      #          else login = nickname, e.g. "Dr Nic" instead of 'drnic'
      # @user.login.gsub!(/\W+/,'').downcase unless @user.login.blank?
      @<%= file_name %>.save
    end
    
end