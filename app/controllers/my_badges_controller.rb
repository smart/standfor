class MyBadgesController < ApplicationController
  layout 'default'
  before_filter :login_required, :only => [:new, :create]
  #before_filter :get_badge
  # GET /my_badges
  # GET /my_badges.xml
  
  def initialize
    @context = "my-badges"
  end
  
  def index
    @my_badges = current_account.my_badges.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_badges }
    end
  end

  # GET /my_badges/1
  # GET /my_badges/1.xml
  def show
    @my_badge = MyBadge.find(params[:id])
    get_share_info
    get_stat_info
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /my_badges/new
  # GET /my_badges/new.xml
  def new
    get_my_badge
    @order = Order.new
    #@my_badge = MyBadge.new
    #session[:badge] = @badge
    session[:my_badge_return_to] = request.request_uri 
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
    #@my_badge = MyBadge.new(params[:my_badge])
    #@my_badge.badge = @badge 
    get_my_badge
    @my_badge.account = current_account 
    if !params[:my_badge].nil? and !params[:my_badge][:access_code].nil?
      	 @badge.access_codes.each do |c|
	          current_account.access_codes << c if c.value == params[:my_badge][:access_code]
         end
    end
    respond_to do |format|
      if @my_badge.save
        flash[:notice] = 'MyBadge was successfully created.'
        format.html { redirect_to :controller =>'customize', :action =>'index', :id => @my_badge  and return false }
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
     @badge = Badge.find(params[:badge_id])
   end

   def get_my_badge
     if !session[:unsaved_badge].nil?
       # This is the transition from the unlogged in state to the logged in state
       # The before_filter :login_requirdd will ensure that current_account is set.
       @my_badge = session[:unsaved_badge]
       session[:unsaved_badge] = nil
       @my_badge.account = current_account
       session[:my_badge] = @my_badge
       return
     end
     @my_badge = session[:my_badge] 
     return if !@my_badge.nil?

     if params[:badge_id].nil?
       @my_badge = Badge.find(params[:badge_id]).my_badges.new
     end
     return if !@my_badge.nil?
     @my_badge = current_account.my_badges.find(params[:my_badge_id])
   end

   def get_share_info
     @shares = Share.find(:all, :params => {:adi_id => @my_badge.adi_id} )
   end

   def get_stat_info
     @statistics = Stat.sort(Stat.find(:all, :params  => {:adi_id => @my_badge.adi_id } ))  
   end

end
