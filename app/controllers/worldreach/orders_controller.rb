class Worldreach::OrdersController < ApplicationController
  # GET /worldreach_orders
  # GET /worldreach_orders.xml
  layout 'worldreach/default'
  before_filter :login_required
  before_filter :get_organization
  before_filter :get_order, :only => [:new, :create, :confirm ] 
  before_filter :get_donations_from_params, :only => [:create]
  before_filter :confirmation_required, :only => [:create]

  def index
    @orders = Order.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worldreach_orders }
    end
  end

  # GET /worldreach_orders/1
  # GET /worldreach_orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /worldreach_orders/new
  # GET /worldreach_orders/new.xml
  def new
		@segments = @organization.segments
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /worldreach_orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /worldreach_orders
  # POST /worldreach_orders.xml
  def create
    respond_to do |format|
      if @order.save
        session[:order] = nil
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to  :controller => '/worldreach/site', :action => 'index'  }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /worldreach_orders/1
  # PUT /worldreach_orders/1.xml
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

  # DELETE /worldreach_orders/1
  # DELETE /worldreach_orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(worldreach_orders_url) }
      format.xml  { head :ok }
    end
  end

  def confirm
  end

  private

  def get_donations_from_params
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
  end

  def confirmation_required
     return true if !params[:confirmed].nil? and params[:confirmed] == 'yes'
     redirect_to worldreach_confirm_order_path and return false
  end

  def get_organization
    @organization = Organization.find_by_site_name('worldreach')  
  end

  def get_order
    @order = session[:order] ||= Order.new
    session[:order_confirmed] ||= 'no'
  end

end
