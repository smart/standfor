class DonationsController < ApplicationController
  # GET /donations
  # GET /donations.xml
  layout 'default'
  before_filter :login_required
  before_filter :get_organization
  before_filter :get_segment
  def index
    @donations = Donation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @donations }
    end
  end

  # GET /donations/1
  # GET /donations/1.xml
  def show
    @donation = Donation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @donation }
    end
  end

  # GET /donations/new
  # GET /donations/new.xml
  def new
    @donation = Donation.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @donation }
    end
  end

  # GET /donations/1/edit
  def edit
    @donation = Donation.find(params[:id])
  end

  # POST /donations
  # POST /donations.xml
  def create
    @donation = Donation.new(params[:donation])
    get_donation_info
    return false unless creditcard_required
    return false unless confirmation_required
    return false unless charge_card 
    @donation.organization = @organization
    @donation.segment = @segment
    @donation.account = current_account 
    @donation.payment_authorization = @authorization
    @donation.last_four_digits = @last_four_digits  

    respond_to do |format|
      if @donation.save
        flash[:notice] = 'Donation was successfully created.'
        format.html { redirect_to(@donation) }
        format.html { redirect_to organization_segment_donation_url(@organization, @segment, @donation) }
        format.xml  { render :xml => @donation, :status => :created, :location => @donation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /donations/1
  # PUT /donations/1.xml
  def update
    @donation = Donation.find(params[:id])

    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        flash[:notice] = 'Donation was successfully updated.'
        format.html { redirect_to organization_segment_donation_url(@organization, @segment, @donation ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.xml
  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to(donations_url) }
      format.xml  { head :ok }
    end
  end

   def confirmation
      get_donation_info
      if params[:id].nil? or params[:id] != 'yes'
         render :action => 'confirmation' 
      else
         session[:order_confirmed] = true 
         redirect_to  :controller => 'donations' , :action => 'create' and return false 
      end
   end
 
  protected

  def get_donation_info
    @badge = session[:badge]
  end

  # need a valid credit card
  def creditcard_required
     if session[:creditcard].nil?
       no_card 
     else
      @creditcard = session[:creditcard]
        return true 
      end
      return false
  end

  def no_card
       session['payment_redirect'] = request.request_uri 
       session[:donation] = @donation
       redirect_to :controller => 'authorizations', :action => 'new' and return false
   end

   def confirmation_required
      if params[:confirmed].nil? and params[:confirmed] !=  'yes'
        render :template => '/donations/confirmation' and return false
      else
        return true
      end
   end

   def charge_card
     gateway = ActiveMerchant::Billing::BogusGateway.new
     response = gateway.authorize(@donation.amount, @creditcard)
     if response.success?
       @authorization = response.authorization 
       @last_four_digits = session[:last_four] 
       session[:creditcard] = nil
       session[:last_four] = nil
       session[:donation] = nil
       return true
     else
       no_card
     end
     return false
  end

  private

   # user need to confirm purchase amount

  private
  def get_organization
    @organization = Organization.find(params[:organization_id]) 
  end

  def get_segment
    @segment= Segment.find(params[:segment_id]) 
  end

end
