class OrdersController < ApplicationController
  layout 'default'
  before_filter :login_required
  before_filter :get_organization_and_segment
  before_filter :get_order 
  before_filter :set_donation_amounts_from_params , :only => [:create]
  before_filter :amount_required, :only => [:create]
  before_filter :creditcard_required, :only => [:create, :confirm]
  before_filter :authorization_required, :only => [:create]

  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

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

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    respond_to do |format|
      if @order.save
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to organization_segment_order_path(@organization, @segment, @order ) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to(@order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def amount_required
    return true if @order.amount.to_i > 0
    flash[:notice] = "A minimum donation is amount required"
    redirect_to new_organization_segment_order_path and return false
  end

  def creditcard_required 
    return true if !@order.creditcard.nil?
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
        redirect_to new_creditcard_path and return false
      end
 end 

 def set_donation_amounts_from_params
    @order.donations = []
    donation = Donation.new
    donation.segment = @segment
    donation.account = current_account 
    donation.amount = params[:segment][@segment.site_name].to_i 
    donation.organization = @organization
    @order.donations << donation
    @order.account = current_account
    @order.amount = @order.total 
 end

end
