class AdisController < ApplicationController
   before_filter :update_statistics

  def index
    respond_to do |format|
      format.html {  redirect_to my_badge_landing_url(params[:id])  }
      format.jpg  {  render_adi }
      format.gif  {  render_adi }
      format.png  {  render_adi }
    end
  end
  
  def click_adi
    @hit = @my_badge.sponsorship_hits.find_by_ip(request.env['REMOTE_ADDR'] , :order => "created_at DESC", :limit => 1)
    unless @hit.nil?
    @my_badge.sponsorship_clicks.create(:sponsorship => @hit.sponsorship, 
                                        :sponsorship_hit => @hit, 
                                        :golden => @hit.golden, 
                                        :ip => request.env['REMOTE_ADDR'], 
                                        :referrer => request.env['HTTP_REFERER'] )
    @golden = @hit.golden
    redirect_to ADISERVER + "/adis/#{@my_badge.adi_id}.html?golden=#{@golden}&sponsor=#{@hit.sponsorship.sponsor.id}"
    else
      redirect_to "/"
    end
  end
  
  def render_adi
    #@sponsorship = @my_badge.all_sponsorships[rand(@my_badge.all_sponsorships.length - 1)]
    #@golden = @sponsorship.send_golden? 
    #adi_response = Net::HTTP.get_response(URI.parse(ADISERVER + "/adis/#{@my_badge.adi_id}.png?golden=#{@golden}&sponsor=#{@sponsorship.sponsor_id}"))  || (raise Exception, 'Image resource not specified')
    adi_response = Net::HTTP.get_response(URI.parse(ADISERVER + "/adis/#{@my_badge.adi_id}.png"))
    send_data adi_response.body, :filename => params[:action] + '.png', :type =>'image/png', :disposition => 'inline'
    #if adi_response['x-adi-authentication'] == "true"
    #  @my_badge.sponsorship_hits.create(:sponsorship => @sponsorship, :golden => @golden, :ip => request.env["REMOTE_ADDR"], :referrer => request.env['HTTP_REFERER'] )
    #end
  end
   
  protected

  def update_statistics
    @my_badge = MyBadge.find_by_public_adi_id(params[:id])
    if params[:ext] == 'html'  # an adi has been clicked
      @hit = @my_badge.sponsorship_hits.find_by_ip(request.env['REMOTE_ADDR'] , :order => "created_at DESC", :limit => 1)
      if  !@hit.nil?
        @my_badge.sponsorship_clicks.create(:sponsorship => @hit.sponsorship, 
                                        :sponsorship_hit => @hit, 
                                        :golden => @hit.golden, 
                                        :ip => request.env['REMOTE_ADDR'], 
                                        :referrer => request.env['HTTP_REFERER'] )
      else
        p '----------------------'
        p 'hit is nil'
        p 'What do we do in these case and why?'
        p '----------------------'
      end
    else  # the request is for image data
       @sponsorship_hit = SponsorshipHit.create(:my_badge_id => @my_badge.id, 
                                                :sponsorship_id => 1, 
                                                :golden => 1, 
                                                :ip => request.env['REMOTE_ADDR'], 
                                                :referrer => request.env['HTTP_REFERER'] )
    end
  end

end
