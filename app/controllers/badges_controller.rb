class BadgesController < ApplicationController
  layout 'default'
  helper  'badges'
  #before_filter :get_organization_and_segment
  #access_control [:new, :create, :update, :edit, :delete, :index]  => "admin" 

  # GET /badges
  # GET /badges.xml
  def index
    check_authorization
    #@badges = Badge.find(:all, :conditions => ["organization_id = ? and segment_id = ?", @organization.id, @segment.id ] )
    @badges = Badge.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @badges }
    end
  end

  # GET /badges/1
  # GET /badges/1.xml
  def show
    @badge = Badge.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /badges/new
  # GET /badges/new.xml
  def new
    @badge = Badge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /badges/1/edit
  def edit
    @badge = Badge.find(params[:id])
  end

  # POST /badges
  # POST /badges.xml
  def create
    @badge = Badge.new(params[:badge])

    respond_to do |format|
      if @badge.save
        flash[:notice] = 'Badge was successfully created.'
        format.html { redirect_to organization_segment_badge_url(@organization, @segment,  @badge) }
        format.xml  { render :xml => @badge, :status => :created, :location => @badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /badges/1
  # PUT /badges/1.xml
  def update
    @badge = Badge.find(params[:id])
    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        flash[:notice] = 'Badge was successfully updated.'
        format.html { redirect_to organization_segment_badge_url(@organization,@segment,  @badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1
  # DELETE /badges/1.xml
  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(organization_segment_badges_url) }
      format.xml  { head :ok }
    end
  end

  def requirements 
    @badge = Badge.find(params[:id])
  end

  def permission_denied
    flash[:notice] = "You don't have privileges to access this action" 
    render :template => '/shared/permission_denied'
    #redirect_to :action => 'denied' and return false
  end

  protected

  def check_authorization
   return true
  end 

  private
  def get_organization_and_segment
   @organization = Organization.find(params[:organization_id])
   @segment = Segment.find(params[:segment_id])
  end

end
