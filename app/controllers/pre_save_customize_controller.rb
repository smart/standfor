class PreSaveCustomizeController < CustomizeController
  #before_filter :login_required, :only => []
  def get_my_badge
    session[:new_badge] ||= Badge.find(params[:badge_id]).my_badges.new 
    unless session[:new_badge].badge_id == params[:badge_id]
      session[:new_badge] ||= Badge.find(params[:badge_id]).my_badges.new
    end
     @my_badge = session[:new_badge]
  end
end