module StyleSystem

  def style_info
    @style_info ||= load_from_param || load_from_segment || load_from_organization || session[:style_info]
    session[:style_info] = @style_info
    return @style_info
  end
  
  def style_image_path(path, ext = "png")
    return false if style_info.nil?
    return url_for(:controller => "style", :ext => ext, :action => path, :style_info =>style_info )
  end
  
  def load_from_param
    begin
      return params[:style_info] ? StyleInfo.find(params[:style_info]) : nil
    rescue
      return nil
    end
  end
  
  def load_from_segment
    return nil if @segment.nil?
    return @segment.style_info ? @segment.style_info : nil
  end
  
  def load_from_organization
    return nil if @organization.nil?
    return @organization.style_info ? @organization.style_info : nil
  end   
  
  def self.included(base)
      base.send :helper_method, :style_info, :style_image_path
    end
end