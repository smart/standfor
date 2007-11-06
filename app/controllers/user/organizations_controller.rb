class User::OrganizationsController < ApplicationController
  layout 'default' 
  before_filter :login_required
  # GET /user_organizations
  # GET /user_organizations.xml
  def index
    @organizations = current_account.organizations

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_organizations }
    end
  end

  # GET /user_organizations/1
  # GET /user_organizations/1.xml
  def show
    @organization = User::Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /user_organizations/new
  # GET /user_organizations/new.xml
  def new
    @organization = User::Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /user_organizations/1/edit
  def edit
    @organization = User::Organization.find(params[:id])
  end

  # POST /user_organizations
  # POST /user_organizations.xml
  def create
    @organization = User::Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        flash[:notice] = 'User::Organization was successfully created.'
        format.html { redirect_to(@organization) }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_organizations/1
  # PUT /user_organizations/1.xml
  def update
    @organization = User::Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'User::Organization was successfully updated.'
        format.html { redirect_to(@organization) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_organizations/1
  # DELETE /user_organizations/1.xml
  def destroy
    @organization = User::Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(user_organizations_url) }
      format.xml  { head :ok }
    end
  end
end
