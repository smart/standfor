class Worldreach::DonationsController < ApplicationController
  # GET /worldreach_donations
  # GET /worldreach_donations.xml
  layout 'worldreach/default'
  before_filter :get_organization
  def index
    @donations = @organization.donations
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worldreach_donations }
    end
  end

  # GET /worldreach_donations/1
  # GET /worldreach_donations/1.xml
  def show
    @donation = Donation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @donation }
    end
  end

  # GET /worldreach_donations/new
  # GET /worldreach_donations/new.xml
  def new
    @donation = Donation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @donation }
    end
  end

  # GET /worldreach_donations/1/edit
  def edit
    @donation = Donation.find(params[:id])
  end

  # POST /worldreach_donations
  # POST /worldreach_donations.xml
  def create
    @donation = Donation.new(params[:donation])

    respond_to do |format|
      if @donation.save
        flash[:notice] = 'Donation was successfully created.'
        format.html { redirect_to(@donation) }
        format.xml  { render :xml => @donation, :status => :created, :location => @donation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /worldreach_donations/1
  # PUT /worldreach_donations/1.xml
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

  # DELETE /worldreach_donations/1
  # DELETE /worldreach_donations/1.xml
  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to(worldreach_donations_url) }
      format.xml  { head :ok }
    end
  end

  private
  def get_organization
    @organization = Organization.find_by_site_name('worldreach')  
  end
end
