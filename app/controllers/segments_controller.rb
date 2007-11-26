class SegmentsController < ApplicationController
  layout 'default'
  before_filter :organization_required, :except => [:denied]
  # GET /segments
  # GET /segments.xml
  
  
  def index
    @segments = Segments.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @segments }
    end
  end

  # GET /segments/1
  # GET /segments/1.xml
  def show
    @segment = Segment.find(params[:id])
    @organization = Organization.find(@segment.organization_id)
    session[:segment_return_to] = request.request_uri 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /segments/new
  # GET /segments/new.xml
  def new
    @segment = Segments.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /segments/1/edit
  def edit
    @segment = Segments.find(params[:id])
  end

  # POST /segments
  # POST /segments.xml
  def create
    @segment = Segment.new(params[:segment])
    @segment.organization = @organization 
    respond_to do |format|
      if @segment.save
        flash[:notice] = 'Segments was successfully created.'
        format.html { redirect_to organization_segment_url(@segment.organization, @segment) }
        format.xml  { render :xml => @segments, :status => :created, :location => @segment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @segments.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /segments/1
  # PUT /segments/1.xml
  def update
    @segment = Segment.find(params[:id])
    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        flash[:notice] = 'Segments was successfully updated.'
        format.html { redirect_to organization_segment_url(@segment.organization, @segment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /segments/1
  # DELETE /segments/1.xml
  def destroy
    @segment = Segment.find(params[:id])
    @segment.destroy

    respond_to do |format|
      format.html { redirect_to(segments_url) }
      format.xml  { head :ok }
    end
  end

  private
  def organization_required
    @organization = Organization.find(params[:organization_id])
  end

end
