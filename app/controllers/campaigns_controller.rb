class CampaignsController < ApplicationController
  layout 'default' 
  before_filter :login_required
  before_filter :organization_and_segment_required, :except => [:denied]

  # GET /campaigns
  # GET /campaigns.xml
  def index
    @campaigns = Campaign.find(:all, 
		:conditions => ["organization_id = ? and admin_id = ? ",  
				@organization.id, current_account.id ]  )
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.xml
  def show
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.xml
  def new
    @campaign = Campaign.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id], :conditions => ["admin_id = ? ", current_account.id ] )
  end

  # POST /campaigns
  # POST /campaigns.xml
  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.organization  = @organization 
    @campaign.admin_id = current_account.id 
    respond_to do |format|
      if @campaign.save
        flash[:notice] = 'Campaign was successfully created.'
        format.html { redirect_to organization_segment_campaign_url(@organization, @segment, @segment) }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.xml
  def update
    @campaign = Campaign.find(params[:id])
    @campaign.admin_id = current_account.id 
    @campaign.organization  = @organization 
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        flash[:notice] = 'Campaign was successfully updated.'
        format.html { redirect_to organization_segment_campaign_url(@organization, @segment, @segment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.xml
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to(organization_campaigns_url) }
      format.xml  { head :ok }
    end
  end

  def denied
  end

  protected

  def permission_denied
    flash[:notice] = "You don't have privileges to access this action" 
    render :template => '/shared/permission_denied'
    #redirect_to :action => 'denied' and return false
  end

  private
  def organization_and_segment_required
    @organization = Organization.find(params[:organization_id])
    @segment = Segment.find(params[:segment_id])
  end

end