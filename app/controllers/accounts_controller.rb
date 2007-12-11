class AccountsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
	layout 'default'
  include YouserSystem




  def new
  end
  
  def finish_registration
    @account = current_account
    @account.my_badge_referrer = session[:my_badge_referrer] if !session[:my_badge_referrer].nil?
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
    @local_user = LocalUser.new(params[:account])
    if @local_user.save
      successful_local_user_login(@local_user)
      return false
    else
      flash[:notice] = 'Could not save account.'
      render :template => "/sessions/new"
    end
  end

end
