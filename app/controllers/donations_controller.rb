class DonationsController < ApplicationController
  layout 'default'
  before_filter :login_required ,:only => [:create]
  #before_filter :organization_required
  #before_filter :segment_required
  #before_filter :badge_required

  # GET /donations
  # GET /donations.xml
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
    begin
      session['badge'] = Badge.find(params[:badge])
    rescue
    end
    session['donate_return_to'] = request.request_uri 
    get_donation_info
    @donation = @organization.donations.build
    @donation.segment = @segment

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
  #
  def create
    get_donation_info
    @donation = session[:donation] || @organization.donations.new(params[:donation])
    @donation.segment =  @segment
    @donation.badge =  @badge 
    @donation.account = current_account
    return false unless creditcard_required
    return false unless confirmation_required
    return false unless charge_card 
    @donation.payment_authorization = @authorization
    @donation.last_four_digits = @last_four_digits  
    session[:donation] = @donation

    respond_to do |format|
      if @donation.save
        session[:donation] = nil
        session[:order_confirmed] = nil
        session[:badge] = nil
        flash[:notice] = 'Donation was successfully created.'
        format.html { donation_redirect } #redirect_to(@donation)  
	format.xml  { render :xml => @donation, :status => :created, :location => @donation }
      else
        #THROW REALLY NASTY ERROR HERE
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
        format.html { redirect_to(@donation) }
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

  def select_organization
    begin
      @organization = Organization.find(params[:organization][:id])
      redirect_to  :controller =>  'donations', :action => 'new', :organization => @organization
    rescue
      render :action => 'choose_organization' and return
    end

  end

  def donation_redirect 
     if @badge and @segment 
       session[:badge] = nil
       redirect_to :controller=>'my_badges', :action => 'new', :badge  => @badge , :segment => @segment.site_name
     elsif @segment
       redirect_to :controller=>'segments',:action => 'show',:segment => @segment.site_name
     else
       redirect_to :controller=>'organziations',:action => 'show',:organization => @organization.site_name
     end
     false
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

   def confirmation
      get_donation_info
      if params[:id].nil? or params[:id] != 'yes'
         render :action => 'confirmation' 
      else
         session[:order_confirmed] = true 
         redirect_to  :controller => 'donations' , :action => 'create' and return false 
      end
   end


   def creditcard_required

      if session[:creditcard].nil?
        no_card 
      else
	@creditcard = session[:creditcard]
        return true 
      end
      return false
   end

   def confirmation_required
      if session[:order_confirmed].nil?
         no_confirmation
      else
        @confirmation = session[:order_confirmed]
        return true 
      end
      return false
   end

   def no_card
       session['payment_redirect'] = request.request_uri 
       session[:donation] = @donation
       redirect_to :controller => 'authorizations', :action => 'new' and return false
   end

   def no_confirmation
       session['confirmation_redirect'] = request.request_uri 
       session[:donation] = @donation
       redirect_to :controller => 'donations', :action => 'confirmation', :organization => @organization.site_name, :segment =>  @segment.site_name   and return false
   end
  
  private

  def get_donation_info
    begin
      @organization = Organization.find_by_site_name(params[:organization] )
    rescue
      render :action => 'choose_organization' and return
    end
    @segment = (params[:segment] ? @organization.segments.find_by_site_name(params[:segment]) : nil)
    @badge = (params[:badge] ? @organization.badges.find(params[:badge]) : session[:badge] )
    session[:badge] = @badge
  end
   
end
