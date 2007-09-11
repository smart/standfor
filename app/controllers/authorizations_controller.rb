class AuthorizationsController < ApplicationController
  require 'active_merchant'
  layout 'default'

  def new
    @authorization = Authorization.new
    @badge = Badge.find(params[:badge])
    @segment = Segment.find(params[:segment] )
    @amount = params[:amount]
  end

  def create
    @badge = Badge.find(params[:badge])
    @segment = Segment.find(params[:segment] )
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
	gateway = ActiveMerchant::Billing::BogusGateway.new
	response = gateway.authorize(@amount, creditcard)
	if response.success?
	   gateway.capture(@amount, response.authorization )
	   @authorization = Authorization.new
	   @authorization.badge = @badge 
	   @authorization.account = current_account 
	   @authorization.authorization_code = response.authorization 
	   @authorization.last_four_digits = params[:authorization][:number].strip.slice(-4,4)
	   @authorization.status = true
	   @authorization.save
           redirect_to donation_create_url + "?badge=#{@badge.id}&segment=#{@segment.id}&donation[amount]=#{@amount}" 

	else
	   render :action => 'new'
	end
     else
	   render :action => 'new'
     end

  end

end
