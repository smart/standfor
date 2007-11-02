class Worldreach::ChartsController < ApplicationController
  require 'gruff'

  def pie 
      g = Gruff::Pie.new("280x200")
      g.title = "My Donations" 
      session[:order].donations.each do |donation| 
       g.data(donation.segment.name, [donation.amount] ) 
      end    
      send_data(g.to_blob, 
                :disposition => 'inline', 
                :type => 'image/png', 
                :filename => "pie.png")
 end

end 
