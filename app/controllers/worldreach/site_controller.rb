class Worldreach::SiteController < ApplicationController
   layout 'worldreach/default'
   before_filter :get_organization
   before_filter :get_order

   def index
		@context = 'home'
   end

	def toggle_cause
		segment = Segment.find_by_site_name(params[:id])
		@segments = @organization.segments
		session[:causes][segment.site_name] = (session[:causes][segment.site_name].nil?) ? 'selected' : nil
    img = "segment_#{segment.id}"
		render :update do |page|
       if (session[:causes][segment.site_name].nil?)  
         page[img].replace( image_tag('worldreach/icons/select_off.png', :alt => "#{segment.name} not selected", :id => "segment_#{segment.id}") )
       else
         page[img].replace( image_tag('worldreach/icons/select_on.png', :alt => "#{segment.name} selected", :id => "segment_#{segment.id}") )
       end

    # TODO, we will have to determine how to toggle this behavior
    if true
       page.replace_html 'segment-form', :partial =>  '/worldreach/orders/segment_form', :locals => {:organization => @organization, :order => session[:order] } 
    end

		end
	end

   private

   def get_organization
     @organization = Organization.find_by_site_name('worldreach')
   end

   def get_order
     @order = session[:order] || nil 
   end

end
