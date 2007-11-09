class User::MyBadgesController < ApplicationController
  layout 'default' 
  helper 'user::my_badges'
  helper 'badges'
  before_filter :login_required
  before_filter :get_my_badge, :only => [:update, :sponsorship_options, :merit_options, :show, :share, :customize]
  before_filter :sponsorship_option_required, :only => [:show]
  before_filter :merit_option_required, :only => [:show]

 #  get_share_info
 #  get_stat_info

  # GET /user_my_badges
  # GET /user_my_badges.xml
  def index
    @my_badges = current_account.my_badges 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_my_badges }
    end
  end

  # GET /user_my_badges/1
  # GET /user_my_badges/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /user_my_badges/new
  # GET /user_my_badges/new.xml
  def new
    @my_badge = User::MyBadge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_badge }
    end
  end

  # GET /user_my_badges/1/edit
  def edit
    @my_badge = User::MyBadge.find(params[:id])
  end

  # POST /user_my_badges
  # POST /user_my_badges.xml
  def create
    @my_badge = User::MyBadge.new(params[:my_badge])

    respond_to do |format|
      if @my_badge.save
        flash[:notice] = 'User::MyBadge was successfully created.'
        format.html { redirect_to(@my_badge) }
        format.xml  { render :xml => @my_badge, :status => :created, :location => @my_badge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_my_badges/1
  # PUT /user_my_badges/1.xml
  def update
    get_my_badge
    respond_to do |format|
      if @my_badge.update_attributes(params[:my_badge])
        flash[:notice] = 'MyBadge was successfully updated.'
        format.html { redirect_to user_my_badge_url(@my_badge) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_badge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_my_badges/1
  # DELETE /user_my_badges/1.xml
  def destroy
    @my_badge = User::MyBadge.find(params[:id])
    @my_badge.destroy

    respond_to do |format|
      format.html { redirect_to(user_my_badges_url) }
      format.xml  { head :ok }
    end
  end

  def sponsorship_options
  end

  def merit_options
  end

  def share 
  end

  def customize 
  end


   protected

   def get_my_badge
     @my_badge = current_account.my_badges.find(params[:id])
   end
 
   def sponsorship_option_required   
    return true if !@my_badge.sponsorship_option.nil? and !@my_badge.sponsorship_option.blank?
    render :action =>  :sponsorship_options and return false 
   end

   def merit_option_required   
    return true if !@my_badge.merit_option.nil? and !@my_badge.merit_option.blank?
    render :action =>  :merit_options  and return false 
   end
  
   def get_share_info
     @shares = Share.find(:all, :params => {:adi_id => @my_badge.adi_id} )
   end

   def get_stat_info
     @statistics = Stat.sort(Stat.find(:all, :params  => {:adi_id => @my_badge.adi_id } ))  
   end

end
