class Admin::MyBadgesController < AdminController
  make_resourceful do
    actions :all
    belongs_to :account
  end
=begin  
  layout "admin.html.erb"
  before_filter :get_account

  # GET /admin_my_badges
  # GET /admin_my_badges.xml
  def index
    @my_badges = MyBadge.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_badges }
    end
  end

  # GET /admin_my_badges/1
  # GET /admin_my_badges/1.xml
  def show
    @my_badge = MyBadge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /admin_my_badges/new
  # GET /admin_my_badges/new.xml
  def new
    @my_badge = MyBadge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /admin_my_badges/1/edit
  def edit
    @my_badge = MyBadge.find(params[:id])
  end

  # POST /admin_my_badges
  # POST /admin_my_badges.xml
  def create
    @my_badge = MyBadge.new(params[:my_badge])

    respond_to do |format|
      if @my_badge.save
        flash[:notice] = 'MyBadge was successfully created.'
        format.html { redirect_to(@my_badge) }
        format.xml  { render :xml => @my_badge, :status => :created, :location => @my_badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_my_badges/1
  # PUT /admin_my_badges/1.xml
  def update
    @my_badge = MyBadge.find(params[:id])

    respond_to do |format|
      if @my_badge.update_attributes(params[:my_badge])
        flash[:notice] = 'MyBadge was successfully updated.'
        format.html { redirect_to(@my_badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_my_badges/1
  # DELETE /admin_my_badges/1.xml
  def destroy
    @my_badge = MyBadge.find(params[:id])
    @my_badge.destroy

    respond_to do |format|
      format.html { redirect_to(admin_my_badges_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_account
    @account = Account.find( params[:account_id] )
  end
=end
end
