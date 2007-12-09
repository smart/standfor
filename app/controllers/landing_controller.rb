class LandingController < ApplicationController
  layout 'default'

  def index
    @my_badge = MyBadge.find_by_public_adi_id(params[:id])
    @adi = Adi.find(@my_badge.adi_id)
    respond_to do |format|
      format.html 
    end
  end

end
