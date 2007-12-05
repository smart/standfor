class User::CustomizeController < ApplicationController
  require 'RMagick'
  layout 'default'
  helper 'customize'
  before_filter :login_required
  before_filter :get_my_badge

   def index 
     @customizables =  Customization.find(:all, :params => {:adi_id => @my_badge.adi_id } )
     render :template  => 'shared/customize/index.html.erb' 
   end

   def choose_customizable 
     @customization = Customization.find(URI::escape(params[:customizable_name]),
                                        :params => { :adi_id => @my_badge.adi_id } )
     render :action => "shared/customize/choose_customizable.rjs"
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
     render :action => '../../shared/customize/update.rjs'
   end

   def save
    Customization.commit(@my_badge.adi_id)
    @my_badge.save_thumbnails
    flash[:notice] = 'Your changes have been saved.'
    redirect_to user_my_badge_path(@my_badge)
   end

   def reset
     @adi = Adi.find(@my_badge.adi_id)
     @adi.reset
     render :action => '../../shared/customize/update.rjs'
   end

   private 

   def get_my_badge
     @my_badge = current_account.my_badges.find(params[:id])
   end

end
