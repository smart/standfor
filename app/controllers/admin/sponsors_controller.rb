class Admin::SponsorsController < ApplicationController
  
  helper 'sponsors'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 

  # GET /admin_sponsors
  # GET /admin_sponsors.xml
  def index
    @sponsors = Sponsor.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_sponsors }
    end
  end

  # GET /admin_sponsors/1
  # GET /admin_sponsors/1.xml
  def show
    @sponsor = Sponsor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sponsor }
    end
  end

  # GET /admin_sponsors/new
  # GET /admin_sponsors/new.xml
  def new
    @sponsor = Sponsor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sponsor }
    end
  end

  # GET /admin_sponsors/1/edit
  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  # POST /admin_sponsors
  # POST /admin_sponsors.xml
  def create

    @sponsor = Sponsor.new(params[:sponsor])
    respond_to do |format|
      if @sponsor.save
        flash[:notice] = 'Sponsor was successfully created.'
        format.html { redirect_to(@sponsor) }
        format.xml  { render :xml => @sponsor, :status => :created, :location => @sponsor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_sponsors/1
  # PUT /admin_sponsors/1.xml
  def update
    @sponsor = Sponsor.find(params[:id])
    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        flash[:notice] = 'Sponsor was successfully updated.'
        format.html { redirect_to(@sponsor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sponsor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_sponsors/1
  # DELETE /admin_sponsors/1.xml
  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy

    respond_to do |format|
      format.html { redirect_to(admin_sponsors_url) }
      format.xml  { head :ok }
    end
  end
end
