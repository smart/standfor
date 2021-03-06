class Orgadmin::CampaignsController < ApplicationController
  layout '/orgadmin/default'
  before_filter :get_organization
  # GET /orgadmin_campaigns
  # GET /orgadmin_campaigns.xml
  def index
    @campaigns = Campaign.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_campaigns }
    end
  end

  # GET /orgadmin_campaigns/1
  # GET /orgadmin_campaigns/1.xml
  def show
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /orgadmin_campaigns/new
  # GET /orgadmin_campaigns/new.xml
  def new
    @campaign = Campaign.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /orgadmin_campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
  end

  # POST /orgadmin_campaigns
  # POST /orgadmin_campaigns.xml
  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.admin_id  = @organization.admin_id 
    respond_to do |format|
      if @campaign.save
        flash[:notice] = 'Campaign was successfully created.'
        format.html { redirect_to orgadmin_organization_campaign_url(@organization, @campaign) }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgadmin_campaigns/1
  # PUT /orgadmin_campaigns/1.xml
  def update
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        flash[:notice] = 'Campaign was successfully updated.'
        format.html { redirect_to orgadmin_organization_campaign_url(@organization, @campaign) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgadmin_campaigns/1
  # DELETE /orgadmin_campaigns/1.xml
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_campaigns_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_organization
    @organization = Organization.find_by_site_name( params[:organization_id] )
  end

end
