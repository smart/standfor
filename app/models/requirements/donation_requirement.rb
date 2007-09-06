class DonationRequirement < Requirement

   def met?(val)
      return self.value.to_i <= val.to_i
   end

end
