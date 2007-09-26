class Orgadmin::SiteController < ApplicationController
   layout '/orgadmin/default'
   before_filter :login_required
   before_filter :get_organization 

   def index
   end

  private

  def get_organization
       @organization = Organization.find(:first, :conditions => ["admin_id = ? ",  current_account.id ] ) 
       permission_denied if @organization.nil? 
  end

end
