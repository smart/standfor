class Sponsorship < ActiveRecord::Base
   belongs_to :sponsor
   belongs_to :sponsorable, :polymorphic => true
   has_many :sponsorship_clicks
   has_many :sponsorship_hits
   
   def send_golden?
    return false if num_golden_links.nil?
     if num_golden_links > 0 && rand(10) > 8
       true
     else
       false
     end
   end
   
   def days_left
     return 1000 if end_date.nil?
     return (end_date - Date.today).to_i
   end 
     
   
   def unique_total
     self.sponsorship_hits.count(:group => :ip).length * (unique_rate || 0)
   end
   
   def hits_total
     self.sponsorship_hits.count * (hit_rate || 0)
   end
   
   def click_total
     #return 0
     self.sponsorship_clicks.count * (click_rate || 0)
   end
   
   def golden_total
     self.sponsorship_clicks.count("golden = true") * (golden_link_rate || 0 )
   end
   
   
   def total_spent
     return unique_total + hits_total + click_total + golden_total
   end
   
   def max_reached?
     return false if max_amount.nil?
     return (total_spent >= max_amount) ? true : false
   end
   
   def calc_weight
     return 0 if max_reached?
     time_bonus = 100 - (days_left / 0.01)
     time_bonus = 0 if time_bonus < 0
     return ((1 - (total_spent.to_f / max_amount.to_f)) * 100).to_i + time_bonus
   end

     
       
end
