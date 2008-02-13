class AuthorizationsController < ApplicationController
  require 'active_merchant'
  layout 'default'
  before_filter :init

  def new
    @authorization = Authorization.new
    @amount = session[:donation].amount
  end

  def create
    @amount = params[:amount]
    creditcard = ActiveMerchant::Billing::CreditCard.new(
   	:type       => params[:authorization][:card_type].downcase		,
  	:number     => params[:authorization][:number]				,
  	:month      => params[:date][:month]					,
  	:year       => params[:date][:year]					,
  	:first_name => params[:authorization][:first_name]			,
  	:last_name  => params[:authorization][:last_name]			)
     if creditcard.valid?
        session[:last_four] = params[:authorization][:number].strip.slice(-4,4)
        session[:creditcard] = creditcard
        redirect_to session[:authorization_redirect] 
        session[:authorization_redirect]  = nil
        return false
     else
        render :action => 'new'
     end

  end

  def back
    redirect_to :back
  end

   def init
      @return_to = session['donate_return_to']  || ''
   end

end
