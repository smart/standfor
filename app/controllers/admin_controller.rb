class AdminController < ApplicationController
  layout "admin.html.erb"
  before_filter :login_required
end