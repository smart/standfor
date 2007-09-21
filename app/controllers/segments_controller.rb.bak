class SegmentsController < ApplicationController
  before_filter :get_segment, :only => [:show]
  layout 'default'
  # GET /segments
  # GET /segments.xml
  
  def initialize
    @context = 'segments'
  end
  
  def index
    @segments = Segment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @segments }
    end
  end

  # GET /segments/1
  # GET /segments/1.xml
  def show
    #@segment = Segment.find(params[:segment]) 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /segments/new
  # GET /segments/new.xml
  def new
    @segment = Segment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /segments/1/edit
  def edit
    @segment = Segment.find(params[:id])
  end

  # POST /segments
  # POST /segments.xml
  def create
    @segment = Segment.new(params[:segment])

    respond_to do |format|
      if @segment.save
        flash[:notice] = 'Segment was successfully created.'
        format.html { redirect_to :action  => :index }
        format.xml  { render :xml => @segment, :status => :created, :location => @segment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /segments/1
  # PUT /segments/1.xml
  def update
    @segment = Segment.find(params[:id])

    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        flash[:notice] = 'Segment was successfully updated.'
        format.html { redirect_to :action  => :index }
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

   def get_segment
     begin
       @segment = Segment.find_by_site_name(params[:segment]) unless params[:segment].nil?
     rescue
       @segment = Segment.find(params[:id]) if !params[:id].nil?
     end
     @organization = @segment.organization
   end

end
