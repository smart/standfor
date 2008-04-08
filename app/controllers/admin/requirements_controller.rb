class Admin::RequirementsController < ApplicationController
  layout 'application'
  before_filter  :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  before_filter :get_badge

  # GET /admin_requirements
  # GET /admin_requirements.xml
  def index
    @requirements = @badge.requirements

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requirements }
    end
  end

  # GET /admin_requirements/1
  # GET /admin_requirements/1.xml
  def show

    @requirement = @badge.requirements.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requirement }
    end
  end

  # GET /admin_requirements/new
  # GET /admin_requirements/new.xml
  def new
    @requirement = @badge.requirements.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requirement }
    end
  end

  # GET /admin_requirements/1/edit
  def edit
    @requirement = @badge.requirements.find(params[:id])
  end

  # POST /admin_requirements
  # POST /admin_requirements.xml
  def create
    type = params[:requirement][:req_type]
    @requirement = type.constantize.new(params[:requirement]) 
    @requirement.badge = @badge 

    respond_to do |format|
      if @requirement.save
        flash[:notice] = "new requirement for {@badge.name} was successfully created."
        format.html { redirect_to edit_admin_badge_requirement_url(@badge, @requirement)   }
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
    @requirement = @badge.requirements.find(params[:id])
    respond_to do |format|
      if @requirement.update_attributes(params[:requirement])
        flash[:notice] = "requirement for badge #{@badge.name} was successfully updated."
        format.html { redirect_to edit_admin_badge_requirement_path(@badge, @requirement) }
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
    @requirement = @badge.requirements.find(params[:id])
    @requirement.destroy

    respond_to do |format|
      format.html { redirect_to(admin_badge_requirements_url) }
      format.xml  { head :ok }
    end
  end

 private

 def get_badge
   @badge = Badge.find(params[:badge_id])
 end

end
