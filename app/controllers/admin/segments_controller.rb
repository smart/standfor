class Admin::SegmentsController < AdminController 
  before_filter :get_organization
  # GET /admin_segments
  # GET /admin_segments.xml
  def index
    @segments = Segment.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_segments }
    end
  end

  # GET /admin_segments/1
  # GET /admin_segments/1.xml
  def show
    @segment = Segment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /admin_segments/new
  # GET /admin_segments/new.xml
  def new
    @segment = Segment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @segment }
    end
  end

  # GET /admin_segments/1/edit
  def edit
    @segment = Segment.find(params[:id])
  end

  # POST /admin_segments
  # POST /admin_segments.xml
  def create
    @segment = Segment.new(params[:segment])
    @segment.organization = @organization
    respond_to do |format|
      if @segment.save
        flash[:notice] = 'Segment was successfully created.'
        format.html { redirect_to admin_organization_segment_url(@organization, @segment) }
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
    @segment = Segment.find(params[:id])
    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        flash[:notice] = 'Segment was successfully updated.'
        format.html { redirect_to admin_organization_segment_path(@organization, @segment) }
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
    @segment = Segment.find(params[:id])
    @segment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_organization_segments_url(@organization)) }
      format.xml  { head :ok }
    end
  end
 
  private

  def get_organization
    if !params[:organization_id].nil?
      @organization = Organization.find(params[:organization_id])
    else
    
    end
  end

end
