class BadgesController < ApplicationController
  layout 'default'
  helper 'badges'
  before_filter :clear_session_badge, :only => [:index] 
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

  def search
    @segment = params[:search][:segment] 
    @organization = params[:search][:organization] 
    if !@organization.blank? 
      @org = Organization.find_by_id(@organization)
    end
    @terms = params[:search][:term]
    where = "1=1 "
    where << "AND name LIKE '%#{@terms}%' OR organization_id IN (SELECT id FROM organizations where name LIKE '%#{@terms}%') OR segment_id IN (SELECT id FROM segments WHERE name LIKE  '%#{@terms}%') "  if !@terms.blank?
    where << " AND organization_id  = #{@organization} " if !@organization.nil? and !@organization.blank?
    where << " AND segment_id  = #{@segment} " if !@segment.nil? and !@segment.blank?
    @results = Badge.find(:all, :conditions => where )
    render :update do |page|
      page.replace 'badge-list' , :partial => '/shared/badge_list' ,  :locals => { :badges => @results, :size => 'small' } 
      if !@org.nil?
        page.replace_html 'cause-select' , :partial => '/shared/cause_select' ,:locals => { :organization => @org } 
     end
    end
  end

  def update_causes
    if params[:search_organization].blank?
      @results =  Badge.find(:all) 
    else
      @organization = Organization.find_by_id(params[:search_organization])
      @results = @organization.badges
    end
    render :action => 'update_causes.rjs' 
  end

  def update_badges
    where = "1=1"
    @organization = Organization.find_by_id( params[:search_organization] )
    where << " AND organization_id = #{ @organization.id } "  if !@organization.nil?
    if params[:search_segment] and !params[:search_segment].blank?
      @segment = Segment.find_by_id(params[:search_segment]) 
      where << " AND segment_id = #{ @segment.id }"
    end
    @results = Badge.find(:all, :conditions => where ) 
    render :action => 'update_badges.rjs'
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

  def clear_session_badge
    session[:my_badge] = nil
    session[:unsaved_badge] = nil
  end

end
