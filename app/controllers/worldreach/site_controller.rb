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
		if session[:causes][segment.site_name] == 'selected'
			selector = '#' + params[:id] + ' span.checked'
			replace = content_tag(:span, '')
		else
			selector = '#' + params[:id] + ' span'
			replace = content_tag(:span, '', :class => 'checked')
		end
		put selector
		put replace
		render :update do |page|
			page.select(selector) do |item|
	 			page.replace item, replace
 			end
		end
	end

   private

   def get_organization
     @organization = Organization.find_by_site_name('worldreach')
   end

end
