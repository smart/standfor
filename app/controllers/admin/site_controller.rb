class Admin::SiteController < ApplicationController
  layout '/admin/default'
  before_filter :login_required
  access_control [:index]  => 'sympactadmin' 

  def index
  end

end
