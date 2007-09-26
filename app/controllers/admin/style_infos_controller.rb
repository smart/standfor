class Admin::StyleInfosController < ApplicationController
  layout '/admin/default'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  # GET /admin_style_infos
  # GET /admin_style_infos.xml
  def index
    @style_infos = Admin::StyleInfo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_style_infos }
    end
  end

  # GET /admin_style_infos/1
  # GET /admin_style_infos/1.xml
  def show
    @style_info = Admin::StyleInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @style_info }
    end
  end

  # GET /admin_style_infos/new
  # GET /admin_style_infos/new.xml
  def new
    @style_info = Admin::StyleInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @style_info }
    end
  end

  # GET /admin_style_infos/1/edit
  def edit
    @style_info = Admin::StyleInfo.find(params[:id])
  end

  # POST /admin_style_infos
  # POST /admin_style_infos.xml
  def create
    @style_info = Admin::StyleInfo.new(params[:style_info])

    respond_to do |format|
      if @style_info.save
        flash[:notice] = 'Admin::StyleInfo was successfully created.'
        format.html { redirect_to(@style_info) }
        format.xml  { render :xml => @style_info, :status => :created, :location => @style_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @style_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_style_infos/1
  # PUT /admin_style_infos/1.xml
  def update
    @style_info = Admin::StyleInfo.find(params[:id])

    respond_to do |format|
      if @style_info.update_attributes(params[:style_info])
        flash[:notice] = 'Admin::StyleInfo was successfully updated.'
        format.html { redirect_to(@style_info) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_style_infos/1
  # DELETE /admin_style_infos/1.xml
  def destroy
    @style_info = Admin::StyleInfo.find(params[:id])
    @style_info.destroy

    respond_to do |format|
      format.html { redirect_to(admin_style_infos_url) }
      format.xml  { head :ok }
    end
  end
end
