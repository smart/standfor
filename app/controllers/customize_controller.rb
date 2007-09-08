class CustomizeController < ApplicationController
  layout 'default'

   before_filter :get_my_badge

   def index 
   end


   private 

   def get_my_badge
     @my_badge = MyBadge.find(params[:id]) 
   end

end
