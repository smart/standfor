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

   def _get_my_badge
     @my_badge = session[:unsaved_badge]  
     return if !@my_bage.nil?
     @my_badge = (params[:badge_id] ? Badge.find(params[:badge_id]).my_badges.new : nil)
     return if !@my_bage.nil?
     if params[:badge_id]
      session[:unsaved_badge] = Badge.find(params[:badge_id]).my_badges.new if @my_badge.badge_id != params[:badge_id]
      @my_badge = session[:unsaved_badge]
     end
     redirect_to("/") if @my_badge.nil?
  end

end
