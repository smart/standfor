class Orgadmin::OrganizationsController < ApplicationController
  layout '/orgadmin/default'
  helper 'organizations'
  # GET /orgadmin_organizations
  # GET /orgadmin_organizations.xml
  before_filter :login_required 

  def index
    @organizations = Organization.find(:all, :conditions => ["admin_id = ? ", current_account.id ] )
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_organizations }
    end
  end

  # GET /orgadmin_organizations/1
  # GET /orgadmin_organizations/1.xml
  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /orgadmin_organizations/new
  # GET /orgadmin_organizations/new.xml
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /orgadmin_organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # POST /orgadmin_organizations
  # POST /orgadmin_organizations.xml
  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        flash[:notice] = 'Organization was successfully created.'
        format.html { redirect_to(@organization) }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgadmin_organizations/1
  # PUT /orgadmin_organizations/1.xml
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        format.html { redirect_to orgadmin_organization_url(@organization) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgadmin_organizations/1
  # DELETE /orgadmin_organizations/1.xml
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_organizations_url) }
      format.xml  { head :ok }
    end
  end

end
