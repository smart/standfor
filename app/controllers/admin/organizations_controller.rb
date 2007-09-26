class Admin::OrganizationsController < ApplicationController
  layout '/admin/default'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  # GET /admin_organizations
  # GET /admin_organizations.xml
  def index
    @organizations = Admin::Organization.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_organizations }
    end
  end

  # GET /admin_organizations/1
  # GET /admin_organizations/1.xml
  def show
    @organization = Admin::Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /admin_organizations/new
  # GET /admin_organizations/new.xml
  def new
    @organization = Admin::Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /admin_organizations/1/edit
  def edit
    @organization = Admin::Organization.find(params[:id])
  end

  # POST /admin_organizations
  # POST /admin_organizations.xml
  def create
    @organization = Admin::Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        flash[:notice] = 'Admin::Organization was successfully created.'
        format.html { redirect_to(@organization) }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_organizations/1
  # PUT /admin_organizations/1.xml
  def update
    @organization = Admin::Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Admin::Organization was successfully updated.'
        format.html { redirect_to(@organization) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_organizations/1
  # DELETE /admin_organizations/1.xml
  def destroy
    @organization = Admin::Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(admin_organizations_url) }
      format.xml  { head :ok }
    end
  end
end
