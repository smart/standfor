class MyBadgesController < ApplicationController
  layout 'default'
  before_filter :login_required, :only => [:new, :create]
  before_filter :get_my_badge, :only => [:new, :create, :customize]
  
  def initialize
    @context = "my-badges"
  end
  
  def show
    @my_badge = MyBadge.find(params[:id])
    respond_to do |format|
      format.html 
    end
  end

  def new
    session[:my_badge_return_to] = request.request_uri 
    @order = Order.new
    respond_to do |format|
      format.html 
    end
  end

  def create
    @order = Order.new
    collect_access_code
    session[:my_badge_return_to] = request.request_uri 
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

   def customize 
   end

   private

   def collect_access_code
    return false if params[:my_badge].nil? or params[:my_badge][:access_code].nil?
    code  = params[:my_badge][:access_code]
    begin 
      access_code=AccessCode.find(:first, :conditions => ["value = ? and scope_id = ? ",code , @my_badge.badge.id] ) 
      account.access_codes << access_code
    rescue
    end
   end

   def get_badge
     @badge = Badge.find(params[:badge_id])
   end

   def get_my_badge
     if !session[:unsaved_badge].nil?
       @my_badge = session[:unsaved_badge]
       session[:unsaved_badge] = nil
       @my_badge.account = current_account
       session[:my_badge] = @my_badge
       return
     end
     @my_badge = session[:my_badge] 
     return if !@my_badge.nil?
     if !params[:badge_id].nil?
       @my_badge = Badge.find(params[:badge_id]).my_badges.new
       @my_badge.account = current_account
       session[:my_badge] = @my_badge
     end
     return if !@my_badge.nil?
     @my_badge = current_account.my_badges.find(params[:my_badge_id])
   end

end
