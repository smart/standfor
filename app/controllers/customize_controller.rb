class CustomizeController < ApplicationController
  require 'RMagick'
  layout 'default'
  before_filter :get_my_badge

   def index 
     @customizables =  Customization.find(:all, :params => {:adi_id => @my_badge.adi_id } )
     render :template  => '/shared/customize/index.html.erb' 
   end

   def choose_customizable 
     @customization = Customization.find(URI::escape(params[:customizable_name]),
                                        :params => { :adi_id => @my_badge.adi_id } )
                                        p @customization
     render :action => "../shared/customize/choose_customizable.rjs"
   end

   def update
     if params[:customization] == 'Background Image' 
       path = File.join(RAILS_ROOT,'public', 'images', 'customization', @option_value )  
       image = Magick::Image::read(path).first
       image_data = Base64.encode64(image.to_blob)
     end
     
     Customization.set_value(@my_badge.adi_id, params[:customization], params[:option_value]  || '', image_data || nil)
     
     render :action => '../shared/customize/update.rjs'
   end

   def reset
     @adi = Adi.find(@my_badge.adi_id)
     @adi.reset
     render :action => '../shared/customize/update.rjs'
   end

end
