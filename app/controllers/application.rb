# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include StandforAccountSystem 
  include YouserSystem
  # Pick a unique cookie name to distinguish our session data from others'
  #
  session :session_key => '_standfor_session_id'

  before_filter :init
  
  def init
   
    if params[:embedded]
       site_name = request.host.match(/standfor\.(\w+)\.org/)[1]    
       params[:organization] = site_name
    end

      @organization = Organization.find_by_site_name(params[:organization], :include => :segments )  if !params[:organization].nil?
      @segment = @organization.segments.find_by_site_name(params[:segment]) if !params[:segment].nil?
 
  end

end
