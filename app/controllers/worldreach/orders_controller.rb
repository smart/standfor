class Worldreach::OrdersController < ApplicationController
  require 'gruff'
  layout 'worldreach/default'
  before_filter :get_organization
  before_filter :login_required, :except => [:new] 
  before_filter :get_order 
  before_filter :set_donation_amounts_from_params , :only => [:create]
  before_filter :amount_required, :except => [:new, :receipt] 
  before_filter :creditcard_required, :only => [:create, :confirm]
  before_filter :confirmation_required, :only => [:create]
  before_filter :authorization_required, :only => [:create]

   def ssl_required?
     false and ENV['RAILS_ENV'] == 'production'
  end

	def initialize
		@context = 'orders'
	end
	
  def new
  end

  def create
    set_donation_amounts_from_params
    respond_to do |format|
      if @order.save
        session[:order] = nil
        session[:causes] = {}  #clear selected segments
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to  :controller => 'orders', :action => 'receipt', :id => @order }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def confirm
  end

  def new_creditcard
    @creditcard = Creditcard.new
    @segments = @organization.segments
  end

  def save_creditcard
    @creditcard = Creditcard.new
    read_creditcard_params
    creditcard = ActiveMerchant::Billing::CreditCard.new(
      :type   => @creditcard.card_type.downcase ,
      :number => @creditcard.number,
      :month => params[:date][:month],
      :year  => params[:date][:year],
      :first_name => @creditcard.first_name,
      :last_name  => @creditcard.last_name )
     if creditcard.valid?
       @order.creditcard = creditcard
       @order.last_four_digits = @creditcard.number.strip.slice(-4,4)
       flash[:notice] = "Your creditcard has been saved."
       redirect_to worldreach_confirm_order_path and return false 
     else
       flash[:notice] = creditcard.errors
       render :action => :new_creditcard  and return false
     end
  end

   def receipt
     @order = current_account.orders.find( params[:id] )
   end

  protected

   def worldreach_login_required 
       return true if current_account != :false      
       redirect_to worldreach_login_path and return false
   end

   def creditcard_required 
     !@order.creditcard.nil?  ? true : (redirect_to new_worldreach_creditcard_path and return false)
   end

  def confirmation_required
     return true if !params[:confirmed].nil? and params[:confirmed] == 'yes'
     redirect_to worldreach_confirm_order_path and return false
  end

   def authorization_required 
     @order.payment_authorization.nil? ? authorize_card : (redirect_to new_worldreach_creditcard_path and return false)
   end

   def set_donation_amounts_from_params
     @order.donations = []
     @organization.segments.each do |segment|  
        next if session[:causes][segment.site_name].nil?
       donation = Donation.new
       donation.segment = segment
       donation.account = current_account 
       donation.amount = params[:segment][segment.site_name].to_i 
       donation.organization = @organization
       @order.donations << donation
     end
     @order.account = current_account
     @order.amount = @order.total 
   end

  def amount_required
    return true if @order.amount.to_i > 0
    flash[:notice] = "A minimum donation is amount required"
    redirect_to new_worldreach_order_path and return false
  end

  def update_donations
  end

  private

  def get_organization
    @organization = Organization.find_by_site_name('worldreach')  
  end

  def get_order
    @order = session[:order] ||= Order.new
    session[:order_confirmed] ||= 'no'
  end

 def read_creditcard_params
  @creditcard.first_name = params[:creditcard][:first_name] || '' 
  @creditcard.last_name = params[:creditcard][:last_name] || '' 
  @creditcard.number = params[:creditcard][:number] || '' 
  @creditcard.verification_value = params[:creditcard][:verification_value] || '' 
  @creditcard.card_type = params[:creditcard][:card_type] || '' 
  #TODO figure out how to persist date
 end 

  def authorize_card
    #TODO  Replace this with real informaiton when we go into production
    gateway = ActiveMerchant::Billing::BogusGateway.new
    @order.creditcard.number = '1'
    response = gateway.authorize(@order.amount, @order.creditcard)
      if response.success?
        @order.payment_authorization = response.authorization
        return true
      else
        flash[:notice]  = "Authorization of your credit card failed, please check your info and try again"
        redirect_to new_worldreach_creditcard_path and return false
      end
 end 

 end 

