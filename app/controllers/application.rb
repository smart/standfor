# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include StandforAccountSystem 
  include YouserSystem
  include SegmentSystem
  include StyleSystem
  # Pick a unique cookie name to distinguish our session data from others'
  #
  session :session_key => '_standfor_session_id'

  before_filter :init
  before_filter :print_info
  
   def print_info
    if !fbsession.nil?
      p "======"
      p fbsession.session_key.to_s
      p "======="
    end
  end
  
  
  
  def init
    if false  and params[:embedded]
       site_name = request.host.match(/standfor\.(\w+)\.org/)[1]    
       params[:organization] = site_name
    end
    @organization = Organization.find(params[:organization_id], :include => [:segments, :style_info]) if !params[:organization_id].nil?
    @segment = @organization.segments.find(params[:segment_id], :include => [:style_info]) if !params[:segment_id].nil?
  end
  
  

end
