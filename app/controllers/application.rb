# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include StandforAccountSystem 
  # Pick a unique cookie name to distinguish our session data from others'
  #
  session :session_key => '_standfor_session_id'

end
