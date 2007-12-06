class MyBadgesController < ApplicationController
  layout 'default'
  #before_filter :login_required, :only => [:create]
  #before_filter :get_my_badge, :only => [:new, :create, :customize]
  
  def initialize
    @context = "my-badges"
  end
  
  def show
    @my_badge = MyBadge.find_by_public_adi_id(params[:id])
    @adi = Adi.find(@my_badge.adi_id)
    respond_to do |format|
      format.html 
    end
  end

  def new
    @order = Order.new
    respond_to do |format|
      format.html 
    end
  end

  def create
    @order = Order.new
    collect_access_code
    @my_badge.account = current_account 
    respond_to do |format|
      if @my_badge.save
        session[:unsaved_badge] = nil
        session[:my_badge] = nil
        flash[:notice] = 'MyBadge was successfully created.'
        format.html { redirect_to user_my_badge_path(@my_badge) and return false }
      else
        format.html { render :action => "new" }
      end
    end
  end

   private

   def collect_access_code
    return false if params[:my_badge].nil? or params[:my_badge][:access_code].nil?
    code = params[:my_badge][:access_code]
    code_requirement = @my_badge.badge.requirements.find_by_type('CodeRequirement')
    if !code_requirement.nil?
       access_code=AccessCode.find(:first, :conditions => ["value = ? and scope_id = ? ",code,code_requirement.id]) 
       if !access_code.nil?
         current_account.access_codes << access_code
       else
         flash[:notice] = "invalid access code"
         return false
       end 
     end
   end

   def get_badge
     @badge = Badge.find(params[:badge_id])
   end

end
