class AuthorizationsController < ApplicationController
  require 'active_merchant'
  layout 'default'

  def new
  end

  def create
    creditcard = ActiveMerchant::Billing::CreditCard.new(
   	:type       => params[:authorization][:card_type].downcase		,
  	:number     => params[:authorization][:number]				,
  	:month      => params[:date][:month]					,
  	:year       => params[:date][:year]					,
  	:first_name => params[:authorization][:first_name]			,
  	:last_name  => params[:authorization][:last_name]			)
     if creditcard.valid?
        creditcard.number = 1.to_s
	gateway = ActiveMerchant::Billing::BogusGateway.new
	response = gateway.authorize(params[:amount], creditcard)
	if response.success?
	   gateway.capture(params[:amount], response.authorization )
	   session[:authorization] = {}
	   session[:authorization][:authorization_code] = response.authorization
	   session[:authorization][:last_four_digits]= params[:authorization][:number].strip.slice(-4, 4 )
           redirect_to session[:payment_return_to]
	else
	   render :action => 'new'
	end
     else
	   render :action => 'new'
     end

  end

end
