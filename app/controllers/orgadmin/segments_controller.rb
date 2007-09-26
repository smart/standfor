class Orgadmin::SegmentsController < ApplicationController
  layout '/orgadmin/default'
  # GET /orgadmin_segments
  # GET /orgadmin_segments.xml
  def index
    @orgadmin_segments = Orgadmin::Segment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgadmin_segments }
    end
  end

  # GET /orgadmin_segments/1
  # GET /orgadmin_segments/1.xml
  def show
    @segment = Orgadmin::Segment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /orgadmin_segments/new
  # GET /orgadmin_segments/new.xml
  def new
    @segment = Orgadmin::Segment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /orgadmin_segments/1/edit
  def edit
    @segment = Orgadmin::Segment.find(params[:id])
  end

  # POST /orgadmin_segments
  # POST /orgadmin_segments.xml
  def create
    @segment = Orgadmin::Segment.new(params[:segment])

    respond_to do |format|
      if @segment.save
        flash[:notice] = 'Orgadmin::Segment was successfully created.'
        format.html { redirect_to(@segment) }
        format.xml  { render :xml => @segment, :status => :created, :location => @segment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgadmin_segments/1
  # PUT /orgadmin_segments/1.xml
  def update
    @segment = Orgadmin::Segment.find(params[:id])

    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        flash[:notice] = 'Orgadmin::Segment was successfully updated.'
        format.html { redirect_to(@segment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgadmin_segments/1
  # DELETE /orgadmin_segments/1.xml
  def destroy
    @segment = Orgadmin::Segment.find(params[:id])
    @segment.destroy

    respond_to do |format|
      format.html { redirect_to(orgadmin_segments_url) }
      format.xml  { head :ok }
    end
  end
end
