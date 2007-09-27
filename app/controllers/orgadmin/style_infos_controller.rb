class Orgadmin::StyleInfosController < ApplicationController
  layout '/orgadmin/default'
  # GET /orgadmin_style_infos
  # GET /orgadmin_style_infos.xml

  before_filter :get_organization

  def index
    #@style_infos = StyleInfo.find(:all, :conditions => ["organization_id = ? ", @organization.id ])
    @style_infos = [@organization.style_info]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_style_infos }
    end
  end

  # GET /orgadmin_style_infos/1
  # GET /orgadmin_style_infos/1.xml
  def show
    @style_info =StyleInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @style_info }
    end
  end

  # GET /orgadmin_style_infos/new
  # GET /orgadmin_style_infos/new.xml
  def new
    @style_info = StyleInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @style_info }
    end
  end

  # GET /orgadmin_style_infos/1/edit
  def edit
    @style_info = StyleInfo.find(params[:id])
    #@style_info = @organization.style_info
  end

  # POST /orgadmin_style_infos
  # POST /orgadmin_style_infos.xml
  def create
    @style_info = Orgadmin::StyleInfo.new(params[:style_info])

    respond_to do |format|
      if @style_info.save
        flash[:notice] = 'Orgadmin::StyleInfo was successfully created.'
        format.html { redirect_to(@style_info) }
        format.xml  { render :xml => @style_info, :status => :created, :location => @style_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @style_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgadmin_style_infos/1
  # PUT /orgadmin_style_infos/1.xml
  def update
    @style_info = StyleInfo.find(params[:id])

    respond_to do |format|
      if @style_info.update_attributes(params[:style_info])
        flash[:notice] = 'StyleInfo was successfully updated.'
        format.html { redirect_to(@style_info) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgadmin_style_infos/1
  # DELETE /orgadmin_style_infos/1.xml
  def destroy
    @style_info = Orgadmin::StyleInfo.find(params[:id])
    @style_info.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_style_infos_url) }
      format.xml  { head :ok }
    end
  end

  private   
  def get_organization
    @organization = Organization.find_by_site_name( params[:organization_id] )
  end

end
