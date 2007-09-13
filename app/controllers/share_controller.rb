class ShareController < ApplicationController
  layout 'default'

   before_filter :get_my_badge

   def index 
     @customizations = Customization.find(:all, :params => { :adi_id => @my_badge.adi_id } )
      @customizations.each do |customization|
      customization.commit
    end

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

   private 

   def get_my_badge
     @my_badge = MyBadge.find_by_id_and_account_id(params[:id], current_account.id ) 
   end

end
