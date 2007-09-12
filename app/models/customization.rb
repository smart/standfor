class Customization < AdiserverResource
  self.site += "/adis/:adi_id"

  attr_accessor :value
  
  def self.commit(adi_id)
    Customization.put(:commit, :adi_id => adi_id).code == "200" ? true : false 
  end

  def commit
    Customization.put(:commit, :adi_id => @prefix_options[:adi_id])
  end
  
  
  def icon
    return "picture.png" if /picture/i.match(name)
    return "edges.png" if name  == "Top Color"
    return 'edges.png' if name == "Bottom Color"
    return "font.png" if name == "Statement Text"
    return "picture.png" if name == "Background Image"
    return "font.png"
  end
 
end
