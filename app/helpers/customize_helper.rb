module CustomizeHelper

  def option_link(icon_class, text, my_badge)
#    html = image_tag(image, :alt => text)
#    html += text
    html = link_to_remote text, 
      :url => {:controller => "/customize",
      :action => "choose_customizable",
      :customizable_name => text,
      :id => my_badge  },
      :before => "Element.show('indicator')",
      :complete => "Element.hide('indicator')"
    html = content_tag(:li, html, :class => icon_class)
    return html
  end
  
end
