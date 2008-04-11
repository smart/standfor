class Admin::BadgesController < AdminController
  make_resourceful do
    actions :all
    belongs_to :organization, :segment
  end
=begin
  # GET /admin_badges 
  # GET /admin_badges.xml
  def index
    @badges = Badge.find(:all, :conditions => ["organization_id  = ? " , @organization ])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_badges }
    end
  end

  # GET /admin_badges/1
  # GET /admin_badges/1.xml
  def show
    @badge = Badge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /admin_badges/new
  # GET /admin_badges/new.xml
  def new
    @badge = Badge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /admin_badges/1/edit
  def edit
    @badge = Badge.find(params[:id])
  end

  # POST /admin_badges
  # POST /admin_badges.xml
  def create
    @badge = Badge.new(params[:badge])
    @badge.organization = @organization
    respond_to do |format|
      if @badge.save
        flash[:notice] = 'Badge was successfully created.'
        format.html { redirect_to admin_organization_badge_url(@organization, @badge) }
        format.xml  { render :xml => @badge, :status => :created, :location => @badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_badges/1
  # PUT /admin_badges/1.xml
  def update
    @badge = Badge.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        flash[:notice] = 'Badge was successfully updated.'
        format.html { redirect_to admin_organization_badge_url(@organization, @badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_badges/1
  # DELETE /admin_badges/1.xml
  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(admin_organization_badges_url(@organization) ) }
      format.xml  { head :ok }
    end
  end
=end
end
