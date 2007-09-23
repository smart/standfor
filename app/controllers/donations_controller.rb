class DonationsController < ApplicationController
  # GET /donations
  # GET /donations.xml
  layout 'default'
  before_filter :login_required
  before_filter :get_organization_and_segment, :except => [:amount, :choose_amount, :confirm, :choose_confirm]
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
    return false unless amount_required
    @donation.amount = session[:amount] 
    return false unless creditcard_required
    return false unless confirmation_required
    return false unless authorization_required 
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
    @donation.organization = @organization
    @donation.segment = @segment
    @donation.account = current_account 
    @donation.payment_authorization = session[:authorization_code]
    @donation.last_four_digits = session[:last_four] 

    respond_to do |format|
      if @donation.save
        flash[:notice] = 'Donation was successfully created.'
	session[:creditcard] = nil
	session[:order_confirmed] = nil
	session[:last_four] = nil
	session[:amount] = nil 
	session[:donation] = nil 
	session[:badge] = nil
	session[:authorization] = nil
        format.html { 
           if !session[:my_badge_return_to ].nil?
		redirect_to session[:my_badge_return_to]
            elsif !session[:segment_return_to].nil?
		redirect_to session[:segment_return_to] and return false 
            else 
   		raise
	    end
	    return false
	}

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
      if params[:id].nil? or params[:id] != 'yes'
         render :action => 'confirmation' 
      else
         session[:order_confirmed] = true 
         redirect_to  :controller => 'donations' , :action => 'create' and return false 
      end
   end
 
   def amount
   end

   def choose_amount
      if !params[:donations][:amount].nil? and params[:donations][:amount].to_i > 0
 	session[:amount] = params[:donations][:amount].to_i
	redirect_to session[:amount_return_to]  and return false
      end
      flash[:notice] = "amount invalid #{params[:donations][:amount] }"
      render :action => :amount
   end

    def confirm
    end

    def choose_confirm
      if  params[:confirmed] == 'yes'
         session[:order_confirmed] = 'yes' 
	 redirect_to session[:confirmation_redirect]  and return false
      end
      render :action => :confirm
    end

  protected

  # need a valid credit card

  def amount_required
    if session[:amount].nil? 
        session[:amount_return_to] = request.request_uri
	redirect_to url_for(:action => :amount) and return false  
    else
        return true
    end
  end

   def confirmation_required
      if session[:order_confirmed].nil? or session[:order_confirmed] != 'yes' 
	session[:confirmation_redirect] = request.request_uri
	redirect_to url_for(:action => :confirm) and return false  
      else
        return true
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

  def no_card
       session[:authorization_redirect] = request.request_uri 
       session[:donation] = @donation
       redirect_to :controller => 'authorizations', :action => 'new' and return false
   end

  def authorization_required
     if session[:authorization_code].nil?
 	 session[:authorization_redirect] = request.request_uri  
         gateway = ActiveMerchant::Billing::BogusGateway.new
         response = gateway.authorize(@donation.amount, session[:creditcard])
         if response.success?
           session[:authorization_code] = response.authorization 
           return true
         else
           redirect_to :controller => 'authorizations', :action => 'new' and return false
         end
      else
           return true 
      end
  end

   def charge_card
     gateway = ActiveMerchant::Billing::BogusGateway.new
     response = gateway.authorize(@donation.amount, @creditcard)
     if response.success?
       session[:authorization_code] = response.authorization 
       return true
     else
       no_card
     end
     return false
  end

  private

   # user need to confirm purchase amount

  private
  def get_organization_and_segment
    @organization = Organization.find(params[:organization_id]) 
    @segment= Segment.find(params[:segment_id]) 
  end

end
