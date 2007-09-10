class CodeRequirement < Requirement
   has_many :access_codes, :as => :scope

   def met?(account) 
        codes = account.access_codes.find(:all, 
		:conditions  => ["scope_type = 'Requirement' and scope_id = ?  ",  self.id ])
	return !codes.empty?  
   end

end
