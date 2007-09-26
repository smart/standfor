class Admin::CampaignsController < ApplicationController
  layout '/admin/default'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  # GET /admin_campaigns
  # GET /admin_campaigns.xml
  def index
    @campaigns = Admin::Campaign.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_campaigns }
    end
  end

  # GET /admin_campaigns/1
  # GET /admin_campaigns/1.xml
  def show
    @campaign = Admin::Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /admin_campaigns/new
  # GET /admin_campaigns/new.xml
  def new
    @campaign = Admin::Campaign.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /admin_campaigns/1/edit
  def edit
    @campaign = Admin::Campaign.find(params[:id])
  end

  # POST /admin_campaigns
  # POST /admin_campaigns.xml
  def create
    @campaign = Admin::Campaign.new(params[:campaign])

    respond_to do |format|
      if @campaign.save
        flash[:notice] = 'Admin::Campaign was successfully created.'
        format.html { redirect_to(@campaign) }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_campaigns/1
  # PUT /admin_campaigns/1.xml
  def update
    @campaign = Admin::Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        flash[:notice] = 'Admin::Campaign was successfully updated.'
        format.html { redirect_to(@campaign) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_campaigns/1
  # DELETE /admin_campaigns/1.xml
  def destroy
    @campaign = Admin::Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to(admin_campaigns_url) }
      format.xml  { head :ok }
    end
  end
end
