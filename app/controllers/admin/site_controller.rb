class Admin::SiteController < ApplicationController
  before_filter :login_required

  #access_control [:index]  => 'sympactadmin' 

  def index
  end

end
