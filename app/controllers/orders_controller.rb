class OrdersController < ApplicationController
  before_filter :login_required, :except => [:new]
  before_filter :get_organization_and_segment
  before_filter :get_order 
  before_filter :set_donation_amounts_from_params , :only => [:create]
  before_filter :amount_required, :only => [:create]
  before_filter :creditcard_required, :only => [:create, :confirm]
  before_filter :authorization_required, :only => [:create]

  def ssl_required?
      ENV['RAILS_ENV'] == 'production'
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = current_account.orders.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    respond_to do |format|
      if @order.save
        session[:order] = nil
        flash[:notice] = "Thank you for your donation to #{@segment.name}"
        session[:receipt] = "Thank you for your donation! View your receipt from the 'My Account Section' "
        format.html { redirect_to my_badge_create_url }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  protected

  def amount_required
    return true if @order.amount.to_i > 0
    flash[:notice] = "A minimum donation is amount required"
    redirect_to new_organization_segment_order_path and return false
  end

  def creditcard_required 
    if !@order.creditcard.nil?
      @order.last_four_digits = @order.creditcard.number.strip.slice(-4,4)
      return true 
    end
    session[:creditcard_redirect] = new_organization_segment_order_path(@organization,@segment)
    redirect_to new_creditcard_path and return false
  end

  def authorization_required 
     @order.payment_authorization.nil? ? authorize_card : true 
  end

  private 

  def get_organization_and_segment
    @organization = Organization.find_by_site_name(params[:organization_id])
    @segment =  Segment.find_by_site_name(params[:segment_id])
  end 

  def get_order
    session[:order] ||= Order.new
    @order =  session[:order]
    session[:order_confirmed] ||= 'no'
  end

  def authorize_card
    #TODO  Replace this with real informaiton when we go into production
    if  ENV['RAILS_ENV'] == 'production'
      gateway = ActiveMerchant::Billing::PaypalGateway.new( :login => PAYPAL_LOGIN, :password => PAYPAL_PASS, :pem => PAYPAL_PEM )  #test mode is set in environments/(development|production).rb
    else
      gateway = ActiveMerchant::Billing::BogusGateway.new()  #test mode is set in environments/(development|production).rb
      @order.creditcard.number = '1'
    end
    response = gateway.purchase((@order.amount * 100), @order.creditcard, {:ip => request.env["REMOTE_ADDR"]})

      if response.success?
        @order.payment_authorization = response.authorization
        return true
      else
        flash[:notice]  = "Authorization of your credit card failed, please check your info and try again."
        redirect_to new_creditcard_path and return false
      end
 end 

 def set_donation_amounts_from_params
    return if !@order.creditcard.nil?
    @order.donations = []
    donation = Donation.new
    donation.segment = @segment
    donation.account = current_account 
    donation.amount = params[:order][:amount].to_i  if !params[:order].nil?
    donation.organization = @organization
    @order.donations << donation
    @order.account = current_account
    @order.amount = @order.total 
 end

end
