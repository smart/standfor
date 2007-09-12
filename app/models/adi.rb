class Adi < AdiserverResource

  def activate
   Adi.put(:activate, :id => self.id ).code == "200" ? true : false 
   #activate_path = self.class.collection_path(self.prefix_options) + ";activate"
   #(connection.put(activate_path, to_xml).code == "200") ? true : false
  end

  def deactivate
   Adi.put(:deactivate, :id => self.id ).code == "200" ? true : false 
   #deactivate_path = self.class.collection_path(self.prefix_options) + ";deactivate"
   #(connection.put(deactivate_path, to_xml).code == "200") ? true : false
  end

  def public_path
  "#{ADISERVER}/badges/#{self.public_id}" 
  end

  def code_snippet
   "<a href='#{ADISERVER}.html' src=#{self.public_path}.png></a>" 
  end

end
