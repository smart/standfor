class User::ShareController < ApplicationController
  layout 'default'
  before_filter :login_required
  before_filter :get_my_badge

   def index 
     @customizations = Customization.find(:all, :params => { :adi_id => @my_badge.adi_id } )
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

   def signature_one
     render :action => 'signature_one.rjs'
   end

   def signature_two
     @client = params[:q]
     render :action => 'signature_two.rjs'
   end

   def signature_three
     render :action => 'signature_three.rjs'
   end

   def signature_four
     render :action => 'signature_four.rjs'
   end



   private 

   def get_my_badge
     @my_badge = current_account.my_badges.find(params[:id])
   end

end
