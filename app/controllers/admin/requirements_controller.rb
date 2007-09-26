class Admin::RequirementsController < ApplicationController
  layout '/admin/default'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  # GET /admin_requirements
  # GET /admin_requirements.xml
  def index
    @requirements = Admin::Requirement.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_requirements }
    end
  end

  # GET /admin_requirements/1
  # GET /admin_requirements/1.xml
  def show
    @requirement = Admin::Requirement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requirement }
    end
  end

  # GET /admin_requirements/new
  # GET /admin_requirements/new.xml
  def new
    @requirement = Admin::Requirement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requirement }
    end
  end

  # GET /admin_requirements/1/edit
  def edit
    @requirement = Admin::Requirement.find(params[:id])
  end

  # POST /admin_requirements
  # POST /admin_requirements.xml
  def create
    @requirement = Admin::Requirement.new(params[:requirement])

    respond_to do |format|
      if @requirement.save
        flash[:notice] = 'Admin::Requirement was successfully created.'
        format.html { redirect_to(@requirement) }
        format.xml  { render :xml => @requirement, :status => :created, :location => @requirement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requirement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_requirements/1
  # PUT /admin_requirements/1.xml
  def update
    @requirement = Admin::Requirement.find(params[:id])

    respond_to do |format|
      if @requirement.update_attributes(params[:requirement])
        flash[:notice] = 'Admin::Requirement was successfully updated.'
        format.html { redirect_to(@requirement) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requirement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_requirements/1
  # DELETE /admin_requirements/1.xml
  def destroy
    @requirement = Admin::Requirement.find(params[:id])
    @requirement.destroy

    respond_to do |format|
      format.html { redirect_to(admin_requirements_url) }
      format.xml  { head :ok }
    end
  end
end
