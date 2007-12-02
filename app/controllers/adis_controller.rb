class AdisController < ApplicationController

  def index
    @my_badge = MyBadge.find_by_public_adi_id(params[:id])
   
    respond_to do |format|
      format.html {  render_adi }
      format.jpg  {  render_adi }
      format.gif  {  render_adi }
      format.png  {  render_adi }
    end
  end
  
  def click_adi
    @my_badge = MyBadge.find_by_public_adi_id(params[:id])
    @hit = @my_badge.sponsorship_hits.find_by_ip(request.env['REMOTE_ADDR'], :order => "created_at DESC", :limit => 1)
    unless @hit.nil?
    @my_badge.sponsorship_clicks.create(:sponsorship => @hit.sponsorship, :sponsorship_hit => @hit, :golden => @hit.golden, :ip => request.env['REMOTE_ADDR'], :referrer => request.env['HTTP_REFERER'])
    @golden = @hit.golden
    redirect_to ADISERVER+ "/adis/#{@my_badge.adi_id}.html?golden=#{@golden}&sponsor=#{@hit.sponsorship.sponsor.id}"
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
end
