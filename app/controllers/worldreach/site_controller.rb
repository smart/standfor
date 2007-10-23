class Worldreach::SiteController < ApplicationController
   layout 'worldreach/default'
   before_filter :get_organization

   def index
		@context = 'home'
   end

   def toggle_cause
     segment = Segment.find_by_site_name(params[:id])
     @segments = @organization.segments
     session[:causes][segment.site_name] = (session[:causes][segment.site_name].nil?) ? 'selected' : nil  
     render :update do |page|
       page.replace_html 'causes_panel', :partial => '/worldreach/segments/causes'
     end
   end

   private

   def get_organization
     @organization = Organization.find_by_site_name('worldreach')
   end

end
