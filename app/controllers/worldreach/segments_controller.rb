class Worldreach::SegmentsController < ApplicationController
  # GET /worldreach_segments
  # GET /worldreach_segments.xml
  layout 'worldreach/default'
  before_filter :get_organization
  
  def initialize
  	@context = 'causes'	
	end
	
  def index
    @segments = @organization.segments
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worldreach_segments }
    end
  end

  # GET /worldreach_segments/1
  # GET /worldreach_segments/1.xml
  def show
    @segment = Segment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /worldreach_segments/new
  # GET /worldreach_segments/new.xml
  def new
    @segment = Segment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /worldreach_segments/1/edit
  def edit
    @segment = Segment.find(params[:id])
  end

  # POST /worldreach_segments
  # POST /worldreach_segments.xml
  def create
    @segment = Segment.new(params[:segment])

    respond_to do |format|
      if @segment.save
        flash[:notice] = 'Segment was successfully created.'
        format.html { redirect_to(@segment) }
        format.xml  { render :xml => @segment, :status => :created, :location => @segment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /worldreach_segments/1
  # PUT /worldreach_segments/1.xml
  def update
    @segment = Segment.find(params[:id])

    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        flash[:notice] = 'Segment was successfully updated.'
        format.html { redirect_to(@segment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /worldreach_segments/1
  # DELETE /worldreach_segments/1.xml
  def destroy
    @segment = Segment.find(params[:id])
    @segment.destroy

    respond_to do |format|
      format.html { redirect_to(worldreach_segments_url) }
      format.xml  { head :ok }
    end
  end

  private
  def get_organization
    @organization = Organization.find_by_site_name('worldreach')  
  end
end
