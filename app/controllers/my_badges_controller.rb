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
    @order = Order.new
    respond_to do |format|
      format.html 
    end
  end

  def create
    session[:my_badge_return_to] = request.request_uri 
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
      else
        format.html { render :action => "new" }
      end
    end
  end

   def customize 
   end

   private

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
     if params[:badge_id].nil?
       @my_badge = Badge.find(params[:badge_id]).my_badges.new
     end
     return if !@my_badge.nil?
     @my_badge = current_account.my_badges.find(params[:my_badge_id])
   end

end
