class AdminController < ApplicationController
  before_filter :login_required
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin"
  layout "admin.html.erb"
  #before_filter :load_context
  
  def permission_denied
    flash[:warning] = "You must be logged in as an admin to do that."
    redirect_to login_path
  end

  
  def load_context
    case 
    when !get_organization.nil? && !get_segment.nil?
      @organization = Organization.find(get_organization)
      @segment = Segment.find(get_segment)
    when !get_organization.nil? && get_segment.nil?
      @organization = Organization.find(get_organization)
      @segment = @organization.segment
    when get_organization.nil? && !get_segment.nil?
      @segment = Segment.find(get_segment)
      @organization = @segment.organization
    end
    #get_organization != nil? ? @organization = Organization.find_by_id(get_organization) : nil
    
    #get_segment != nil? ? @segment = Segment.find_by_id(get_segment) : nil
  end
  
  def get_organization
    params[:organization_id] ||= nil
  end
  
  def get_segment
    params[:segment_id] ||= nil
  end
end