class CustomizeController < ApplicationController
  require 'RMagick'
  layout 'default'

   before_filter :get_my_badge

   def index 
     @customizables =  Customization.find(:all, :params => {:adi_id => @my_badge.adi_id } )
   end

   def choose_customizable 
     @customization = Customization.find(URI::escape(params[:customizable_name]),
                                        :params => { :adi_id => @my_badge.adi_id } )
     render :action => 'choose_customizable.rjs'
   end

   def update
     @customization = Customization.find( params[:customization],
				       :params =>{:adi_id => @my_badge.adi_id})
     @option_value = params[:option_value]  || ''
     @customization.draft_value = @option_value

     if @customization.name == 'Background Image' 
      path = File.join(RAILS_ROOT,'public', 'images', 'customization', @option_value )  
      image = Magick::Image::read(path).first
      @customization.draft_value = @option_value 
      @customization.image_data = Base64.encode64(image.to_blob)
    end
     @customization.save
     render :action => 'update.rjs'
   end

   private 

   def get_my_badge
     @my_badge = MyBadge.find_by_id_and_account_id(params[:id], current_account.id ) 
   end

end
