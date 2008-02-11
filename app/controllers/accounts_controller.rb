class AccountsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # If you want "remember me" functionality, add this before_filter to Application Controller
	layout 'default'

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

end
