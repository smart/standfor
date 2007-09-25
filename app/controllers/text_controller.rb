class TextController < ApplicationController



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
    create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
  end

  def header_text
    text = params[:text] || ""
    color = params[:color] || "white"
    background = params[:background] || "transparent"
    font = params[:font] || RAILS_ROOT + "/lib/fonts/VAGROBDT.PFB"
    gravity = Magick::CenterGravity
    pointsize = params[:pointsize] || 30
    width = params[:width] || nil
    height = params[:height] || nil
    left = params[:left] || 0
    top = params[:top] || 0
    create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
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
     create_text(text, color, background, font, gravity, pointsize, width, height, left, top)
   end 
  
  def create_text(text, color, background, font, gravity, pointsize, width, height, left, top )
    listing_name = Magick::Image.read("label:#{text}" ) do
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
          
    @output_image = back.composite(text_image, Magick::CenterGravity,  x_offset.to_i, y_offset.to_i, Magick::OverCompositeOp)
    output
  end
  
  def output
    params[:ext] ||= 'png'
    @output_image.format = params[:ext] 
    send_data @output_image.to_blob, :filename => params[:action] + '.' + params[:ext], :type =>'image/' + params[:ext], :disposition => 'inline'
  end



end