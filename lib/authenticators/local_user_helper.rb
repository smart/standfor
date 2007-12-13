module LocalUserHelper

  
  def using_local_user?(login = params[:login])
    params[:login] ? true : false
  end
  
  # Pass optional :required and :optional keys to specify what sreg fields you want.
  # Be sure to yield registration, a third argument in the #authenticate_with_open_id block.
  # REMEMBER: a "required" field is not guaranteed to be returned by OpenID provider
  def local_user_authentication
  
    local_user = LocalUser.authenticate(params[:login], params[:password]) 
    if local_user 
      successful_local_user_login(local_user)
    else
      failed_login( "Failed Authentication")
    end
  end
  
  def successful_local_user_login(local_user)
    unless @account = Account.find_by_youser(local_user.login, "LocalUser")
      @account = Account.new(:create_auth_token => local_user.login, :create_authenticator => "LocalUser")
      assign_local_user_attributes(local_user)
    end
    self.current_account = @account
    successful_login
  end
    
  private
  def assign_local_user_attributes(local_user)
    { 
      :nickname  => 'login', 
      :primary_email  => 'email', 
    }.each do |model_attribute, registration_attribute|
      unless local_user.send("#{registration_attribute}").blank?
        @account.send("#{model_attribute}=", local_user.send("#{registration_attribute}"))
      end
    end
    @account.my_badge_referrer = local_user.my_badge_referrer if @account.my_badge_referrer.blank? 
    @account.save       
  end
  
end
