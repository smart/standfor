class Worldreach::SiteController < ApplicationController
   layout 'worldreach/default'
   before_filter :get_organization

   def index
   end

   private

   def get_organization
     @organization = Organization.find_by_site_name('worldreach')
   end

end
