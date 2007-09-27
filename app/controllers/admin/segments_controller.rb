class Admin::SegmentsController < ApplicationController
  layout '/admin/default'
  before_filter :login_required 
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin" 
  # GET /admin_segments
  # GET /admin_segments.xml
  def index
    @segments = Admin::Segment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_segments }
    end
  end

  # GET /admin_segments/1
  # GET /admin_segments/1.xml
  def show
    @segment = Admin::Segment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /admin_segments/new
  # GET /admin_segments/new.xml
  def new
    @segment = Admin::Segment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /admin_segments/1/edit
  def edit
    @segment = Admin::Segment.find(params[:id])
  end

  # POST /admin_segments
  # POST /admin_segments.xml
  def create
    @segment = Admin::Segment.new(params[:segment])

    respond_to do |format|
      if @segment.save
        flash[:notice] = 'Admin::Segment was successfully created.'
        format.html { redirect_to(@segment) }
        format.xml  { render :xml => @segment, :status => :created, :location => @segment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_segments/1
  # PUT /admin_segments/1.xml
  def update
    @segment = Admin::Segment.find(params[:id])

    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        flash[:notice] = 'Admin::Segment was successfully updated.'
        format.html { redirect_to(@segment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_segments/1
  # DELETE /admin_segments/1.xml
  def destroy
    @segment = Admin::Segment.find(params[:id])
    @segment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_segments_url) }
      format.xml  { head :ok }
    end
  end
end