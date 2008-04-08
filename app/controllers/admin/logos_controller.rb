class Admin::LogosController < ApplicationController
  layout '/admin/default'
  before_filter :get_sponsor
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin"
  # GET /admin_logos
  # GET /admin_logos.xml
  def index
    @logos = Logo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_logos }
    end
  end

  # GET /admin_logos/1
  # GET /admin_logos/1.xml
  def show
    @logo = Logo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @logo }
    end
  end

  # GET /admin_logos/new
  # GET /admin_logos/new.xml
  def new
    @logo = Logo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @logo }
    end
  end

  # GET /admin_logos/1/edit
  def edit
    @logo = Logo.find(params[:id])
  end

  # POST /admin_logos
  # POST /admin_logos.xml
  def create
    @logo = Logo.new(params[:logo])

    respond_to do |format|
      if @logo.save
        flash[:notice] = 'Logo was successfully created.'
        format.html { redirect_to(@logo) }
        format.xml  { render :xml => @logo, :status => :created, :location => @logo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @logo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_logos/1
  # PUT /admin_logos/1.xml
  def update
    @logo = Logo.find(params[:id])

    respond_to do |format|
      if @logo.update_attributes(params[:logo])
        flash[:notice] = 'Logo was successfully updated.'
        format.html { redirect_to(@logo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @logo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_logos/1
  # DELETE /admin_logos/1.xml
  def destroy
    @logo = Logo.find(params[:id])
    @logo.destroy

    respond_to do |format|
      format.html { redirect_to(admin_logos_url) }
      format.xml  { head :ok }
    end
  end
  private 

  def get_sponsor
    @sponsor = Sponsor.find(params[:sponsor_id]) 
  end

end
