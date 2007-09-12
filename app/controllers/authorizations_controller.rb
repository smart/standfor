class AuthorizationsController < ApplicationController
  require 'active_merchant'
  layout 'default'

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
        creditcard.number = 1.to_s
        session[:last_four] =params[:authorization][:number].strip.slice(-4,4)
        session[:creditcard] = creditcard
        redirect_to session['payment_redirect'] 
        session['payment_redirect']  = nil
        return false
     else
        render :action => 'new'
     end

  end

end
