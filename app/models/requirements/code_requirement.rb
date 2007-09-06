class CodeRequirement < Requirement

   def met?(val) 
     self.value == val
   end

end
