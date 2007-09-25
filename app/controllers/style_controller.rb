class StyleController < ApplicationController
  caches_page :solid_shadow_dark_head, :gradient_shadow_light_head, :header_bar, :default
  
  def solid_shadow_dark_head
    p params[:style_info]
    list = Magick::ImageList.new
    drop_shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/shadow/dropshadow.png")
    list << drop_shadow.first
    
    box_fill = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/shadow/fill.png")
    list << box_fill.first
    list << color_image(RAILS_ROOT + "/public/images/colortest/boxes/headers/dark.png", style_info.color_primary)
    @output_image = list.flatten_images
     output
  end
  
  def gradient_shadow_light_head
    list = Magick::ImageList.new
    drop_shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/light/dropshadow.png")
    list << drop_shadow.first
    
    box_fill = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/light/fill.png")
    list << box_fill.first
    list << color_image(RAILS_ROOT + "/public/images/colortest/boxes/headers/light.png", style_info.color_secondary)
    @output_image = list.flatten_images
     output
   end
   
   def solid_smooth_dark_head
    list = Magick::ImageList.new
    box_fill = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/boxes/shadow/fill.png")
    list << box_fill.first
    list << color_image(RAILS_ROOT + "/public/images/colortest/boxes/headers/dark.png", style_info.color_primary)
    @output_image = list.flatten_images
     output
   end
   
   def header_bar
     list = Magick::ImageList.new
     shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/header/bar/dropshadow.png")
     list << shadow.first
     list << color_image(RAILS_ROOT + "/public/images/colortest/header/bar/bar.png", style_info.color_secondary)
     @output_image = list.flatten_images
     output
   end 
   
   def button_large
     @output_image = color_image(RAILS_ROOT + "/public/images/colortest/buttons/large.png", style_info.color_secondary)
     output
   end
   
   def button_large_hover
     @output_image = color_image(RAILS_ROOT + "/public/images/colortest/buttons/large-hover.png", style_info.color_primary)
     output
   end
   
   def header_arrow
     list = Magick::ImageList.new
     backshadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/header/bullets/background_shadow.png")
     list << backshadow.first
     list <<  color_image( RAILS_ROOT + "/public/images/colortest/header/bullets/background.png", style_info.color_secondary)
     shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/header/bullets/arrowshadow.png")
     list << shadow.first
     list << color_image(RAILS_ROOT + "/public/images/colortest/header/bullets/arrows.png", style_info.color_primary)
     @output_image = list.flatten_images
     output
   end
   
   def header_bullet
     list = Magick::ImageList.new 
     backshadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/header/bullets/background_shadow.png")
     list << backshadow.first
     list <<  color_image( RAILS_ROOT + "/public/images/colortest/header/bullets/background.png", style_info.color_secondary)
     shadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/header/bullets/bulletshadow.png")
     list << shadow.first
     list << color_image(RAILS_ROOT + "/public/images/colortest/header/bullets/bullet.png", style_info.color_primary)
     @output_image = list.flatten_images
     output
   end
   
   def header_standfor
     list = Magick::ImageList.new 
     backshadow = Magick::Image.read(RAILS_ROOT + "/public/images/colortest/header/standfor_shadow.png")
     list << backshadow.first
     list <<  color_image( RAILS_ROOT + "/public/images/colortest/header/standfor_background.png", style_info.color_secondary)
     list << color_image(RAILS_ROOT + "/public/images/colortest/header/standfor.png", style_info.color_primary)
     @output_image = list.flatten_images
     output
   end
  
  
  
  def output
    params[:ext] ||= 'png'
    @output_image.format = params[:ext] 
    send_data @output_image.to_blob, :filename => params[:action] + '.' + params[:ext], :type =>'image/' + params[:ext], :disposition => 'inline'
  end
 
  def color_image(base_image, color1 = "black")
    #begin
     dark_color = darken_color(color1)
     light_color = lighten_color(color1)
      list = Magick::ImageList.new
      image =  Magick::Image.read(base_image).first
      list << image
      gradient_list = Magick::ImageList.new
      gradient1 = Magick::Image.read("gradient:#{dark_color}-#{color1} -resize 45") { self.size = "10x100" }
      gradient_list << gradient1.first
      gradient2 = Magick::Image.read("gradient:#{color1}-#{light_color} -resize 45") { self.size = "10x100" }
      gradient_list << gradient2.first
      list << gradient_list.append(true)
      return list.fx("v.p{0,u*v.h}")
#    rescue
#      return image =  Magick::Image.read(base_image).first
#    end
  end
  
  def darken_color(color = "#FFFFFF", level = "88")
    adjust_color(color, level, true)
  end
  
  def lighten_color(color = "#000000", level = "55")
    adjust_color(color, level, false)
  end
  
  def adjust_color(color = "#FFFFFF", level = "CC", darken = true)
   
    adjust_by = level.to_i(base=16)
    return_color = "#"
    colors = [color[1,2].to_i(base=16), color[3,2].to_i(base=16), color[5,2].to_i(base=16) ]
    colors.map do |color|
      color =  (darken ? (color - adjust_by) : (color + adjust_by))
      color = 0 if color < 0
      color = 255 if color > 255
      color = color.to_s(base=16)
      color = "0" + color if color.length != 2
      return_color << color
    end
    return return_color
  end 
    

end
