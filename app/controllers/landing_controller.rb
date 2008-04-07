class LandingController < ApplicationController

  def index
    @my_badge = MyBadge.find_by_public_adi_id(params[:id])
    session[:my_badge_referrer] = @my_badge.id
    @adi = Adi.find(@my_badge.adi_id)
    respond_to do |format|
      format.html 
    end
  end


end
