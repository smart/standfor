module YouserHelper
  include YouserOpenidsHelper
  include YouserFacebookHelper
  
  def create
    # params[:openid_url]
    if using_open_id? && VALID_AUTHENTICATORS['OpenID']
      open_id_authentication
    #params[:facebook]
    elsif using_facebook? && VALID_AUTHENTICATORS['Facebook']
      facebook_authentication    
    else
      normal_create
    end
  end
  
   def normal_create
    throw "Implement me in this controller!"
  end
  
  
    
    def successful_login
      current_user = 
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    end

    def unfinished_registration(identity_url)
      params = {:user => @user.attributes.merge("identity_url" => identity_url)}
      redirect_to new_user_path(params)
      flash[:warning] = "Please complete registration"
    end
    
    def failed_login(message)
      flash.now[:error] = message
      render :action => 'new'
    end
end