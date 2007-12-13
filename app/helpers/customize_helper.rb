module CustomizeHelper

  def option_link(icon_class, text, my_badge)
#    html = image_tag(image, :alt => text)
#    html += text
    css_classes = {
      'picture'   => 'images' ,
      'name text' => 'fonts'  ,
      'color'     => 'edges'  ,
    }
    html = link_to_remote text, 
      :url => {:controller => "/customize",
      :action => "choose_customizable",
      :customizable_name => text,
      :id => my_badge  },
      :before => "Element.show('indicator')",
      :complete => "Element.hide('indicator')"
    html = content_tag(:li, html, :class => css_classes["#{text}"])
    return html
  end
  
end
