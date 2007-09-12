class ShareController < ApplicationController
  layout 'default'

   before_filter :get_my_badge

   def index 
   end

   private 

   def get_my_badge
     @my_badge = MyBadge.find_by_id_and_account_id(params[:id], current_account.id ) 
   end

end
