class DonationsController < ApplicationController
  layout 'default'
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
    get_organization
    get_segment
    @donation = Donation.new
    @donation.segment_id = @segment

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

    @badge = Badge.find(params[:badge])
    @segment = Segment.find(params[:segment])
    return false if !payment_authorization_required( params[:donation][:amount], @badge.organization, @segment )
    @donation = Donation.new(params[:donation])
    @donation.segment_id =  @segment.id
    @donation.organization_id = @badge.organization.id
    @donation.payment_authorization = session[:authorization][:authorization_code]
    @donation.last_four_digits = session[:authorization][:last_four_digits]
    @donation.account = current_account 

    respond_to do |format|
      if @donation.save
        session[:authorization] = nil
        flash[:notice] = 'Donation was successfully created.'
        format.html { redirect_back_or_default('/') } #redirect_to(@donation)  
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

  private

  def get_organization
    begin
      @organization = Organization.find(params[:organization] )
    rescue
      render :action => 'choose_organization' and return
    end
  end

  def get_segment
    begin
      @segment = Segment.find(params[:segment]) 
    rescue
      @segment = @organization.segments.first
    end 
  end

end
