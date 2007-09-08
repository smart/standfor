class MyBadgesController < ApplicationController
  layout 'default'

  before_filter :get_badge  
  before_filter :badge_authorization_required

  # GET /my_badges
  # GET /my_badges.xml
  def index
    @my_badges = MyBadge.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_badges }
    end
  end

  # GET /my_badges/1
  # GET /my_badges/1.xml
  def show
    @my_badge = MyBadge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /my_badges/new
  # GET /my_badges/new.xml
  def new
    @my_badge = MyBadge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /my_badges/1/edit
  def edit
    @my_badge = MyBadge.find(params[:id])
  end

  # POST /my_badges
  # POST /my_badges.xml
  def create
    @my_badge = MyBadge.new(params[:my_badge])
    @my_badge.account = current_account 
    @my_badge.badge  = @badge 

    respond_to do |format|
      if @my_badge.save
        flash[:notice] = 'MyBadge was successfully created.'
        format.html {redirect_to :controller =>'customize', :action =>'index', :id => @my_badge }
        format.xml  { render :xml => @my_badge, :status => :created, :location => @my_badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my_badges/1
  # PUT /my_badges/1.xml
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

  # DELETE /my_badges/1
  # DELETE /my_badges/1.xml
  def destroy
    @my_badge = MyBadge.find(params[:id])
    @my_badge.destroy

    respond_to do |format|
      format.html { redirect_to(my_badges_url) }
      format.xml  { head :ok }
    end
  end

   def customize 
    @my_badge = MyBadge.find(params[:id])
   end
  

 private

  def get_badge
     params[:my_badge] ||= {}
    begin
     @badge = Badge.find(params[:badge_id])
    rescue
     @badge = Badge.find(params[:id])
    end
  end

end
