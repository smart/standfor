class ShareController < ApplicationController
  layout 'default'
  before_filter :login_required
  before_filter :get_my_badge

   def index 
     @customizations = Customization.commit(@my_badge.adi_id)
     @shares  = Share.find(:all, :params => {:adi_id => @my_badge.adi_id } )
   end

   def choose
     @share  = Share.find(params[:share], :params => {:adi_id => @my_badge.adi_id }  ) 
     render :action => 'choose.rjs'
   end

   def do 
     @share = Share.find(params[:share], :params => {:adi_id => @my_badge.adi_id }  )
     @response = @share.post(:go, params[:share_it])
     @failed = @response.code == "200" ? false : true
     render :action => "do.rjs"
   end

   def download_signature
      @share  = Share.find("Embed%20Code", :params => {:adi_id => @my_badge.adi_id }  ) 
      send_data @share.snippet.strip , :filename => "emai.signature.#{@my_badge.adi_id}.html", :type =>'text/plain' , :disposition => 'attachment'
   end

   private 

   def get_my_badge
     if !session[:unsaved_badge].nil?
       # This is the transition from the unlogged in state to the logged in state
       # The before_filter :login_required will ensure that current_account is set.
       @my_badge = session[:unsaved_badge]
       session[:unsaved_badge] = nil
       @my_badge.account = current_account
       @my_badge.save 
       session[:my_badge] = @my_badge
       return
     end
     @my_badge = session[:my_badge] 
     return if !@my_badge.nil?
     @my_badge = current_account.my_badges.find(params[:my_badge_id])
   end

end
