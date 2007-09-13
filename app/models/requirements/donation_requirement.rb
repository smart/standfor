class DonationRequirement < Requirement

   def met?(account)
       total = 0
       #account.donations.find(:all, :conditions => self.badge.segment_id).each do |d|
       account.donations.find_all_by_segment_id( self.badge.segment_id).each do |d|
         total += d.amount 	
      end
      return (total >= self.value.to_i) ? true : false
   end

end
