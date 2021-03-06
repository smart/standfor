class User::MyBadgesController < ApplicationController
   
  helper 'user::my_badges'
  helper 'badges'
  before_filter :login_required
  before_filter :get_my_badge, :only => [:new, :create, :update, :sponsorship_options, :merit_options, :show, :share, :customize]
  before_filter :show_receipt, :only => [:show]
  before_filter :check_for_existing, :only => [:create]

#  before_filter :sponsorship_option_required, :only => [:show]
#  before_filter :merit_option_required, :only => [:show]

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
    @order = Order.new
    existing_badge = current_account.my_badges.find_by_badge_id(@my_badge.badge_id)
    if !existing_badge.nil?
      flash[:notice] = "you already have the badge #{existing_badge.badge.name} in your account " 
      redirect_to user_my_badge_url(existing_badge) and return false
    end
    if @my_badge.available?(current_account)
       @my_badge.account = current_account 
       if @my_badge.save
          session[:unsaved_badge] = nil
          flash[:notice] = "You have successfully earned this badge.  Now share it!"
          redirect_to user_my_badge_share_url(@my_badge) and return false
       else 
          raise Exception, 'Could not save my_badge'
       end
    end
    if !@my_badge.minimum_donation.nil?
       @order.amount = @my_badge.minimum_donation
    end
    respond_to do |format|
      format.html 
    end
  end

  # GET /user_my_badges/1/edit
  def edit
    @my_badge = User::MyBadge.find(params[:id])
  end

  # POST /user_my_badges
  # POST /user_my_badges.xml
  def create
    @order = Order.new
    collect_access_code
    @my_badge.account = current_account 
    respond_to do |format|
      if @my_badge.save
        session[:unsaved_badge] = nil
        flash[:notice] = "Your badge was successfully created."
        #format.html { redirect_to user_my_badge_url(@my_badge) }
        format.html { redirect_to user_my_badge_share_url(@my_badge) }
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
        flash[:notice] = 'Your badge was successfully updated.'
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

  def search
    @segment = params[:search][:segment] 
    @organization = params[:search][:organization] 
    if !@organization.blank? 
      @org = Organization.find_by_id(@organization)
    end
    @terms = params[:search][:term]
    where = "account_id =  #{current_account.id} "

    if !@organization.blank?
      where << " AND badge_id in ( SELECT id FROM badges WHERE organization_id  = #{@organization} ) "
    end
    results = MyBadge.find(:all, :conditions => where )
    if !@segment.blank?
       results.each_with_index do |r,i|
         results[i] = nil if r.badge.segment.id.to_s != @segment.to_s
         results.compact!
       end
    end
    render :update do |page|
      page.replace 'badge-list' , :partial => '/shared/badge_list' ,  :locals => { :badges => results, :size => 'small' } 
      if !@org.nil?
        page.replace_html 'cause-select' , :partial => '/shared/cause_select' , :locals => { :organization => @org } 
     end
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

  def update_causes
    if !params[:search_organization].nil? and  !params[:search_organization].blank?
       @organization = Organization.find_by_id(params[:search_organization])
       where = "badge_id  IN ( SELECT id FROM badges where organization_id = #{@organization.id} ) " 
    else
       @organization = nil
       where = "1=1"
    end
    @results = current_account.my_badges.find(:all, :conditions =>  where )
    render :action => 'update_causes.rjs'
  end

  def update_badges
    @organization = Organization.find_by_id(params[:search_organization])
    where = "1=1"
    if !params[:search_segment].nil? and !params[:search_segment].blank?
      @segment = Segment.find_by_id(params[:search_segment])
      where = "badge_id IN (SELECT id FROM badges WHERE segment_id  = #{@segment.id} )"  
    end
    @results = current_account.my_badges.find(:all, :conditions => where )
    render :action => 'update_badges.rjs'
  end


   protected

   def collect_access_code
    return false if params[:my_badge].nil? or params[:my_badge][:access_code].nil?
    code = params[:my_badge][:access_code]
    code_requirement = @my_badge.badge.requirements.find_by_type_and_value('CodeRequirement', code)
    if !code_requirement.nil?
       access_code = AccessCode.find(:first, :conditions => [" value = ? and scope_id = ? ", code , code_requirement.id] ) 
       access_code = AccessCode.create(:scope_type => 'CodeRequirement', :scope_id => code_requirement.id, :value => code ) if access_code.nil?
       current_account.access_codes << access_code
     else
       flash[:notice] = "The access code entered for this badge is not valid."
       return false
     end 
   end

   def show_receipt
    if !session[:receipt].nil?
      flash[:notice] = session[:receipt]
      session[:receipt] = nil
    end
   end

   def sponsorship_option_required   
    return true if !@my_badge.sponsorship_option.nil? and !@my_badge.sponsorship_option.blank?
    flash[:warning] = 'You must specify sponsorship options'
    render :action =>  :sponsorship_options and return false 
   end

   def merit_option_required   
    return true if !@my_badge.merit_option.nil? and !@my_badge.merit_option.blank?
    flash[:warning] = 'You must specify merit options'
    render :action =>  :merit_options  and return false 
   end
  
   def get_share_info
     @shares = Share.find(:all, :params => {:adi_id => @my_badge.adi_id} )
   end

   def get_stat_info
     @statistics = Stat.sort(Stat.find(:all, :params  => {:adi_id => @my_badge.adi_id } ))  
   end

   def get_badge
     @badge = Badge.find(params[:badge_id])
   end

   def check_for_existing
   end

end
