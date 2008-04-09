class AdminController < ApplicationController
  layout "admin.html.erb"
  before_filter :login_required
  access_control [:new, :create, :update, :edit, :destroy, :index]  => "sympactadmin"
  
  def permission_denied
    flash[:warning] = "You must be logged in as an admin to do that."
    redirect_to login_path
  end  
end