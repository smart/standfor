class AccountsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # If you want "remember me" functionality, add this before_filter to Application Controller

  def new
  end
  
  def finish_registration
    @account = current_account
  end
  
  def save_registration
    @account = current_account
    if current_account.update_attributes(params[:account])
      redirect_back_or_default('/') and  return  false
    else
      render :action => 'finish_registration'
    end
  end

  def create
    @context = "login"
    params[:account][:login] = params[:account][:email]
    @local_user = LocalUser.new(params[:account])
    @local_user.my_badge_referrer = session[:my_badge_referrer] if !session[:my_badge_referrer].nil? 
    if @local_user.save
      params[:login] = params[:account][:login]
      params[:password] = params[:account][:password]
      local_user_authentication    
      return false
    else
      flash[:error] = "<li>Account Could not be saved</li>"
       @local_user.errors.full_messages.each do |e|
        flash[:error] << "<li>#{e}</li>"  
      end
      render :template => "/sessions/new"
    end
  end

  def change_password
    @account = Account.verify_reset_code(params[:id])
    if !@account.nil?  
      @local_user = LocalUser.find_by_account_id(@account.id)
      @local_user.password = params[:local_user][:password]
      @local_user.password_confirmation  = params[:local_user][:password_confirmation]
      if valid_local_user(@local_user) and @local_user.save
        @account.expire_reset_code
        flash[:notice] = "your password has been changed."
        flash[:error] = nil
        redirect_to '/' 
      else
        render :action => :reset_password 
      end
    end
  end

  def forgot_password
    return unless request.post?
    if @account = Account.find_by_primary_email(params[:account][:email])
       @account.forgot_password
       @account.save
       flash[:notice] = "A password reset link has been sent to your email address" 
       flash[:error] = nil
       redirect_back_or_default('/')
    else
       flash[:error] = "Could not find a user with that email address"
    end
  end

  def reset_password
    @account = Account.verify_reset_code(params[:id])
    if @account.nil?
       flash[:notice] = "access code invalid" 
       redirect_to new_session_url and return false
     else 
       flash[:notice] = "access code is valid" 
       render :action => :reset_password  
    end
  end

 private

  def valid_local_user(local_user)
    flash[:error] = {} 
    if local_user.password.blank?
      flash[:error] = "password cannot be blank" 
    end
    if local_user.password != local_user.password_confirmation 
      flash[:error] = "password does not match confirmation" 
    end
    return flash[:error].empty?  ? true :  false
  end

end
