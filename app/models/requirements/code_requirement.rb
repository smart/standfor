class CodeRequirement < Requirement

   def met?(account) 
	return !self.badge.account_badge_authorizations.find(:all, :conditions => ["account_id = ? ", account.id ] ).empty?
   end

end
