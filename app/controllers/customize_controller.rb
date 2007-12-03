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
     render :action => "../shared/customize/choose_customizable.rjs"
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
     render :action => '../shared/customize/update.rjs'
   end

end
