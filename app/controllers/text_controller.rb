class TextController < ApplicationController
  # MAKE SURE TO MAKE CACHE ENTRY WHEN YOU CREATE A NEW ACTION!
  caches_page :bread_crumbs, :top_text, :header_text, :basicborder_header, :button_text, :index


  def bread_crumbs
    text = params[:text] || ""
    color = params[:color] || "gray"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 14
    width = params[:width] || nil
    height = params[:height] || 40
    left = params[:left] || 0
    top = params[:top] || 0
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output
  end
  
  def top_text
    text = params[:text] || ""
    color = params[:color] || "white"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 40
    width = params[:width] || nil
    height = params[:height] || nil
    left = params[:left] || 0
    top = params[:top] || 0
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    @output_image = reflection(@output_image)
    output
  end
  
  def navigation_text
		text = params[:text] || ""
    color = params[:color] || "white"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 18
    width = params[:width] || nil
    height = params[:height] || 25
    left = params[:left] || 0
    top = params[:top] || 0
    trim = false
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output(trim)
	end
	
	def side_button
		text = params[:text] || ""
    color = params[:color] || "black"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 16
    width = params[:width] || nil
    height = params[:height] || 23
    left = params[:left] || 0
    top = params[:top] || 0
    trim = false
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output(trim)
	end

  def header_text
    text = params[:text] || ""
    color = params[:color] || "white"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 28
    width = params[:width] || nil
    height = params[:height] || nil
    left = params[:left] || 0
    top = params[:top] || 0
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output
  end
  
  def basicborder_header
  	text = params[:text] || ""
    color = params[:color] || "black"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 20
    width = params[:width] || nil
    height = params[:height] || nil
    left = params[:left] || 0
    top = params[:top] || 0
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output
  end
  
  def button_text
  	text = params[:text] || ""
    color = params[:color] || "black"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 32
    width = params[:width] || nil
    height = params[:height] || 48
    left = params[:left] || 0
    top = params[:top] || 0
    trim = false
     @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output(trim)
  end
  
  def index
    text = params[:text] || ""
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    color = params[:color] || "black"
    background = params[:background] || "transparent"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 14
    width = params[:width] || nil
    height = params[:height] || nil
    left = params[:left] || 0
    top = params[:top] || 0
    @output_image =  create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
    output
   end 
  
  def create_text(text, color, background, font, gravity, pointsize, width, height, left, top )
  	text = CGI.unescape(text)
    listing_name = Magick::Image.read("label:#{text}") do
      self.size =  "#{width}x#{height}"   if ( pointsize == "fit" && (width || height) )
      self.fill = color
      self.background_color = background
      self.font = font
      self.gravity = gravity
      self.pointsize = pointsize.to_i unless pointsize == "fit"
    end

    text_image = listing_name.first
    return_width = width || text_image.columns
    return_height = height || text_image.rows

    back = Magick::Image.new(return_width.to_i,return_height.to_i) { self.background_color = background }
    x_offset = left || 0
    y_offset = top || 0
  
    return back.composite(text_image, Magick::CenterGravity,  x_offset.to_i, y_offset.to_i, Magick::OverCompositeOp)
  end
  
  def reflection(image, x_offset = 0, y_offset = 0, wet_start = 0.2, wet_rate = 0.7 )
    wet_image = image.wet_floor(wet_start, wet_rate)
    image.composite!(wet_image, Magick::CenterGravity, 0, y_offset + (wet_image.rows/ 1.3), Magick::OverCompositeOp)
  end
  
  
  def output(trim = true)
    params[:ext] ||= 'png'
    @output_image = @output_image.trim unless trim == false
    @output_image.format = params[:ext] 
    send_data @output_image.to_blob, :filename => params[:action] + '.' + params[:ext], :type =>'image/' + params[:ext], :disposition => 'inline'
  end



end
