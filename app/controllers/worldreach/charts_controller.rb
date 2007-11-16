class Worldreach::ChartsController < ApplicationController
  require 'gruff'

  def pie 
      g = Gruff::Pie.new("300x175")
      g.title = "My Donations" 
      @order = session[:order] 
      @order  = Order.find(params[:id]) if params[:id]
      @order.donations.each do |donation| 
        g.data(donation.segment.name, [donation.amount] ) 
      end    
      send_data(g.to_blob, 
                :disposition => 'inline', 
                :type => 'image/png', 
                :filename => "pie.png")
 end


end 
