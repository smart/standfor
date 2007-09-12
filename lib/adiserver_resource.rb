class AdiserverResource < ActiveResource::Base
 # replace with deployment url
  self.site = "#{ADISERVER}" 
  site.user = "#{ADISERVER_USER}" 
  site.password = "#{ADISERVER_PASS}" 
end
