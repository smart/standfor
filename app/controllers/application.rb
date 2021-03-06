# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include StandforAccountSystem 
  include SegmentSystem
  #include StyleSystem
  include Younety::Remote
  include ExceptionNotifiable
  include SslRequirement
  # Pick a unique cookie name to distinguish our session data from others'
  helper :all
  session :session_key => '_standfor_session_id'
  before_filter :init
  #before_filter :print_info


  
   def print_info
    if !fbsession.nil?
      #p fbsession.session_key.to_s
    end
  end
  
  def init
    session[:causes] ||= {}
    session[:donations] ||= {}
    session[:current_segment]  ||= ''

    if !request.xhr?
      session[:on_donation_page] = (params[:controller] == '/worldreach/orders' ) 
    end

    @configuration = Configuration.find(:first)
    if false 
       site_name = request.host.match(/standfor\.(\w+)\.org/)[1]    
       params[:organization] = site_name
     end
  end
  
  def permission_denied
    flash[:notice] = "You don't have privileges to access this action"
    render :template => '/shared/permission_denied'
  end  

  def get_my_badge
  	if params[:id]
      @my_badge = MyBadge.find(params[:id])
    end
    return true if @my_badge
    if !session[:unsaved_badge].nil?
      @my_badge = session[:unsaved_badge]
    end
    return true if @my_badge
    if params[:badge_id]
      @my_badge = Badge.find(params[:badge_id]).my_badges.new
      session[:unsaved_badge]  = @my_badge
    end
    return true if @my_badge
    
    raise( Exception , 'Could not find my_badge.' )
  end
  
end
