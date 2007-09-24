class StyleController < ApplicationController
  caches_page :solid_shadow_dark_head, :gradient_shadow_light_head, :default
  
  def solid_shadow_dark_head
    p params[:style_info]
    list = Magick::ImageList.new
    drop_shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/shadow/dropshadow.png")
    list << drop_shadow.first
    
    box_fill = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/shadow/fill.png")
    list << box_fill.first
    list << color_image(RAILS_ROOT + "/public/images/colortest/boxes/headers/dark.png", @style_info.color_primary)
    @output_image = list.flatten_images
     output
  end
  
  def gradient_shadow_light_head
    list = Magick::ImageList.new
    drop_shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/light/dropshadow.png")
    list << drop_shadow.first
    
    box_fill = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/light/fill.png")
    list << box_fill.first
    list << color_image(RAILS_ROOT + "/public/images/colortest/boxes/headers/light.png")
    @output_image = list.flatten_images
     output
   end
   
   def solid_smooth_dark_head
    list = Magick::ImageList.new
    box_fill = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/shadow/fill.png")
    list << box_fill.first
    list << color_image(RAILS_ROOT + "/public/images/colortest/boxes/headers/dark.png", @style_info.color_primary)
    @output_image = list.flatten_images
     output
   end
  
  
  
  def output
    params[:ext] ||= 'png'
    @output_image.format = params[:ext] 
    send_data @output_image.to_blob, :filename => params[:action] + '.' + params[:ext], :type =>'image/' + params[:ext], :disposition => 'inline'
  end
 
  def color_image(base_image, color1 = "black", color2 = "snow")
    begin
      list = Magick::ImageList.new
      image =  Magick::Image.read(base_image).first
      list << image
      gradient = Magick::Image.read("gradient:#{color1}-#{color2} -resize 45") { self.size = "10x100" }
      list << gradient.first
      return list.fx("v.p{0,u*v.h}")
    rescue
      return image =  Magick::Image.read(base_image).first
    end
  end

end
