class User::CustomizeController < ApplicationController
  require 'RMagick'
  layout 'default'
  helper '/user/customize'
  before_filter :login_required
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

   def save
     @customizations = Customization.find(:all, :params => { :adi_id => @my_badge.adi_id } )
      @customizations.each do |customization|
      customization.commit
    end
    flash[:notice] = 'Your changes have been saved.'
    redirect_to user_my_badge_path(@my_badge)
   end

   private 

   def get_my_badge
     @my_badge = current_account.my_badges.find(params[:id])
   end

end
