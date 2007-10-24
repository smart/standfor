class Worldreach::SiteController < ApplicationController
   layout 'worldreach/default'
   before_filter :get_organization

   def index
		@context = 'home'
   end

	#def toggle_cause
	#	segment = Segment.find_by_site_name(params[:id])
	#	@segments = @organization.segments
	#	session[:causes][segment.site_name] = (session[:causes][segment.site_name].nil?) ? 'selected' : nil
  #  li = "segment_#{segment.id}"  
	#	render :update do |page|
  #     if (session[:causes][segment.site_name].nil?)  
  #       page[li].remove_class_name('segment_selected')
  #       page[li].add_class_name('segment_unselected')
  #     else
  #       page[li].add_class_name('segment_selected')
  #       page[li].remove_class_name('segment_unselected')
  #     end
	#	end
	#end
	
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
		end
	end

   private

   def get_organization
     @organization = Organization.find_by_site_name('worldreach')
   end

end
