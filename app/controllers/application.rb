# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include StandforAccountSystem 
  include YouserSystem
  include SegmentSystem
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
  
  def load_style_info
    begin      
      if params[:style_info] 
        @style_info = StyleInfo.find(params[:style_info])  
      else
        @style_info = @organization.style_info unless @organization.nil?
        unless @segment.nil?
          @style_info = @segment.style_info unless @segment.style_info.nil?
        end
      end
    rescue 
      return @style_info = nil
    end
  end
  
  def init
    if false  and params[:embedded]
       site_name = request.host.match(/standfor\.(\w+)\.org/)[1]    
       params[:organization] = site_name
    end
    @organization = Organization.find(params[:organization_id], :include => [:segments, :style_info]) if !params[:organization_id].nil?
    p @organization
    @segment = @organization.segments.find(params[:segment_id], :include => [:style_info]) if !params[:segment_id].nil?
  end

end
