class Admin::OrganizationslogosController < ApplicationController
  layout '/admin/default'
  before_filter :get_organization
  # GET /admin_organizationslogos
  # GET /admin_organizationslogos.xml
  def index

    @organizationslogos = Organizationslogo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_organizationslogos }
    end
  end

  # GET /admin_organizationslogos/1
  # GET /admin_organizationslogos/1.xml
  def show
    @organizationslogo = Organizationslogo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organizationslogo }
    end
  end

  # GET /admin_organizationslogos/new
  # GET /admin_organizationslogos/new.xml
  def new
    @organizationslogo = Organizationslogo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organizationslogo }
    end
  end

  # GET /admin_organizationslogos/1/edit
  def edit
    @organizationslogo = Organizationslogo.find(params[:id])
  end

  # POST /admin_organizationslogos
  # POST /admin_organizationslogos.xml
  def create
     Organizationslogo.find(:all, :conditions => ["organization_id = ? ", @organization.id ]).each do |logo| 
       logo.destroy
     end
    begin
      @organizationslogo =  Organizationslogo.create! params[:organizationslogo]
      @organizationslogo.organization_id  = @organization.id
      @organizationslogo.save
      flash[:notice] = 'Organizationslogo was successfully created.'
      redirect_to admin_organization_organizationslogo_url(@organization, @organizationslogo ) 
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end

  end

  # PUT /admin_organizationslogos/1
  # PUT /admin_organizationslogos/1.xml
  def update
    @organizationslogo = Organizationslogo.find(params[:id])

    respond_to do |format|
      if @organizationslogo.update_attributes(params[:organizationslogo])
        flash[:notice] = 'Organizationslogo was successfully updated.'
        format.html { redirect_to(@organizationslogo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organizationslogo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_organizationslogos/1
  # DELETE /admin_organizationslogos/1.xml
  def destroy
    @organizationslogo = Organizationslogo.find(params[:id])
    @organizationslogo.destroy

    respond_to do |format|
      format.html { redirect_to(admin_organizationslogos_url) }
      format.xml  { head :ok }
    end
  end
  private

  def get_organization
    @organization = Organization.find(params[:organization_id])
  end

end
