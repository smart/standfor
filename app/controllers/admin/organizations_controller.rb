class Admin::OrganizationsController < ApplicationController
  
  helper 'organizations'
  before_filter :login_required 
  #access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  # GET /admin_organizations
  # GET /admin_organizations.xml
  def index
    @organizations = Organization.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_organizations }
    end
  end

  # GET /admin_organizations/1
  # GET /admin_organizations/1.xml
  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /admin_organizations/new
  # GET /admin_organizations/new.xml
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /admin_organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # POST /admin_organizations
  # POST /admin_organizations.xml
  def create
    @organization = Organization.new(params[:organization])
    respond_to do |format|
      if @organization.save
       @organization.tag_list = params[:organization][:tag_list]  
       @style_info = StyleInfo.new
       @style_info.scope_type =  'Organization'
       @style_info.scope_id =  @organization.id
       @style_info.save
       @organization.reload
        flash[:notice] = 'Organization was successfully created.'
        format.html { redirect_to admin_organization_url(@organization) }
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
    @organization = Organization.find(params[:id])
    @organization.tag_list = params[:organization][:tag_list]  
    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        format.html { redirect_to admin_organization_url(@organization) }
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
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(admin_organizations_url) }
      format.xml  { head :ok }
    end
  end
end
