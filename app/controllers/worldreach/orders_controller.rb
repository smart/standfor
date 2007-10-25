class Worldreach::OrdersController < ApplicationController
  layout 'worldreach/default'
  before_filter :get_organization
  before_filter :login_required
  before_filter :get_order 
  before_filter :amount_required, :except => [:new] 
  before_filter :creditcard_required, :only => [:create, :confirm]
  before_filter :confirmation_required, :only => [:create]
  before_filter :authorization_required, :only => [:create]

  def new
  end

  def create
    respond_to do |format|
      if @order.save
        session[:order] = nil
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to  :controller => '/worldreach/site', :action => 'index'  }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def confirm
  end

  def new_creditcard
    @creditcard = Creditcard.new
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

  protected
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

  def amount_required
    return true if @order.total.to_i > 0
    if params[:segment].nil?
       flash[:notice] = "Please select at least one segment."
      redirect_to new_worldreach_order_path and return false 
    end
    @order.donations = []  
    @organization.segments.each do |segment|
       next if session[:causes][segment.site_name].nil? or params[:segment][segment.site_name].to_i < 1
       donation = Donation.new
       donation.segment = segment
       donation.account = current_account 
       donation.amount = params[:segment][segment.site_name].to_i * 100
       donation.organization = @organization
       @order.donations << donation
    end
    @order.account = current_account
    @order.amount = @order.total 

    if @order.amount.to_i < 1
       flash[:notice] = "A minimum donation is amount required"
       redirect_to new_worldreach_order_path and return false
    end
    return true
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
