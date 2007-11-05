class DonationsController < ApplicationController
  # GET /donations
  # GET /donations.xml
  layout 'default'
  before_filter :login_required
  before_filter :segment_required
  before_filter :donation_required, :only => [:confirm, :details, :payment, :create]
  before_filter :details_required, :only => [:confirm, :create]
  before_filter :creditcard_required, :only => [:confirm, :create]
  before_filter :confirmation_required, :only => [:create]
  before_filter :authorization_required, :only => [:create]
  
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
    current_donation = new_donation
    redirect_to :action => :confirm
  end
  
  def confirm
    respond_to do |format|
      format.html { render :template => 'confirm' }
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
    @donation = current_donation

    respond_to do |format|
      if @donation.save
        flash[:notice] = 'Donation was successfully created.'
        session[:donation] = nil
        format.html { redirect_to "/" and return false }
        format.xml  { render :xml => @donation, :status => :created, :location => @donation }
      else
        flash[:notice] = "There was an error saving your donation please try to submit again or email help@standfor.us"
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

   def details
     if params[:donations]
       if !params[:donations][:amount].nil? and params[:donations][:amount].to_i > 0
          current_donation.amount = params[:donations][:amount].to_i
  	      redirect_to_donation_url
  	      return false
       else
         flash[:notice] = "amount invalid #{params[:donations][:amount] }"
       end
     end
   end
    
  def payment

    if params[:authorization]
      creditcard = ActiveMerchant::Billing::CreditCard.new(
     	:type       => params[:authorization][:card_type].downcase		,
    	:number     => params[:authorization][:number]				,
    	:month      => params[:date][:month]					,
    	:year       => params[:date][:year]					,
    	:first_name => params[:authorization][:first_name]			,
    	:last_name  => params[:authorization][:last_name]			)
       if creditcard.valid?
          creditcard.number = 1.to_s
          current_donation.last_four = params[:authorization][:number].strip.slice(-4,4)
          current_donation.creditcard = creditcard
          redirect_to_donation_url
          return false
       else
         flash[:notice] = creditcard.errors
       end
    else
      @authorization = Authorization.new
      @amount = current_donation.amount
    end
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @authorization }
    end
  end

  protected

  # need a valid credit card

  def details_required
    current_donation.amount ? true : (redirect_to url_for(:action => :details) and return false)
  end
  
  def creditcard_required
    current_donation.creditcard ? true :  (redirect_to :action => 'payment' and return false)
  end
  
  def confirmation_required
    (params[:confirmed] == "yes") ? true : (redirect_to :action => "new" and return false)
   end
   
   def authorization_required
     current_donation.authorization ? true : authorize_card
   end

  def authorize_card
    gateway = ActiveMerchant::Billing::BogusGateway.new
    response = gateway.authorize(current_donation.amount, current_donation.creditcard)
      if response.success?
        current_donation.payment_authorization = response.authorization 
        return true
      else
        flash[:notice]  = "Authorization of your credit card failed, please check your info and try again"
        redirect_to :action => 'payment' and return false
      end
  end

  private  
    def donation_required
      valid_donation ? true : (redirect_to :action => :new and return false)
    end
    
    def valid_donation
      return false if current_donation.nil?
      return false if current_donation.segment != @segment
      return false if current_donation.organization != @organization
      return false if current_donation.account != current_account
      return true
    end
    
    def redirect_to_donation_url
      redirect_to :action => "confirm"
      return false
    end
    
  # Accesses the current donation from the session.
    def current_donation
      @current_donation ||= (session[:donation]) || new_donation
    end
    
    # Store the given account in the session.
    def current_donation=(new_donation)
      session[:donation] = (new_donation.nil? || new_donation.is_a?(Symbol)) ? nil : new_donation
      @current_donation = new_donation
    end
    
    def new_donation
      begin
        donation = Donation.new()
        donation.organization = @organization
        donation.segment = @segment
        donation.account = current_account 
        session[:donation] = donation
        return donation
      rescue 
        return false
      end
    end
    
    def self.included(base)
      base.send :helper_method, :current_donation
    end

end
