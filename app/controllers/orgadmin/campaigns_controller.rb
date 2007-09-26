class Orgadmin::CampaignsController < ApplicationController
  layout '/orgadmin/default'
  # GET /orgadmin_campaigns
  # GET /orgadmin_campaigns.xml
  def index
    @orgadmin_campaigns = Orgadmin::Campaign.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_campaigns }
    end
  end

  # GET /orgadmin_campaigns/1
  # GET /orgadmin_campaigns/1.xml
  def show
    @campaign = Orgadmin::Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /orgadmin_campaigns/new
  # GET /orgadmin_campaigns/new.xml
  def new
    @campaign = Orgadmin::Campaign.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /orgadmin_campaigns/1/edit
  def edit
    @campaign = Orgadmin::Campaign.find(params[:id])
  end

  # POST /orgadmin_campaigns
  # POST /orgadmin_campaigns.xml
  def create
    @campaign = Orgadmin::Campaign.new(params[:campaign])

    respond_to do |format|
      if @campaign.save
        flash[:notice] = 'Orgadmin::Campaign was successfully created.'
        format.html { redirect_to(@campaign) }
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
    @campaign = Orgadmin::Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        flash[:notice] = 'Orgadmin::Campaign was successfully updated.'
        format.html { redirect_to(@campaign) }
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
    @campaign = Orgadmin::Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_campaigns_url) }
      format.xml  { head :ok }
    end
  end
end
