class CodeRequirement < Requirement
   has_many :access_codes, :as => :scope

   def met?(account) 
        p '--------------------------------------'
        p  'called'
        p '--------------------------------------'
        codes = account.access_codes.find(:all,:conditions =>[" scope_type = 'CodeRequirement' and scope_id = ? ",  self.id ])
        p '--------------------------------------'
        p  codes 
        p '--------------------------------------'
	      return !codes.empty?  
   end

end
