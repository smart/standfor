class Orgadmin::BadgesController < ApplicationController
 layout '/orgadmin/default'
  before_filter :login_required 
  before_filter :get_organization
  #access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactorgadmin" 

  # GET /orgadmin_badges
  # GET /orgadmin_badges.xml
  def index
    @badges = Badge.find(:all, :conditions => ["organization_id  = ? " , @organization ])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_badges }
    end
  end

  # GET /orgadmin_badges/1
  # GET /orgadmin_badges/1.xml
  def show
    @badge = Badge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /orgadmin_badges/new
  # GET /orgadmin_badges/new.xml
  def new
    @badge = Badge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /orgadmin_badges/1/edit
  def edit
    @badge = Badge.find(params[:id])
  end

  # POST /orgadmin_badges
  # POST /orgadmin_badges.xml
  def create
    @badge = Badge.new(params[:badge])
    @badge.organization = @organization
    respond_to do |format|
      if @badge.save
        flash[:notice] = 'Badge was successfully created.'
        format.html { redirect_to orgadmin_organization_badge_url(@organization, @badge) }
        format.xml  { render :xml => @badge, :status => :created, :location => @badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgadmin_badges/1
  # PUT /orgadmin_badges/1.xml
  def update
    @badge = Badge.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        flash[:notice] = 'Badge was successfully updated.'
        format.html { redirect_to orgadmin_organization_badge_url(@organization, @badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgadmin_badges/1
  # DELETE /orgadmin_badges/1.xml
  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_badges_url) }
      format.xml  { head :ok }
    end
  end

  private
  def get_organization
    @organization = Organization.find(params[:organization_id])
  end
end
