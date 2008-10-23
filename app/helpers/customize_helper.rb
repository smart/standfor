module CustomizeHelper

  def option_link(icon_class, text, my_badge)
    css_classes = {
      'picture'   => 'images' ,
      'name_text' => 'fonts'  ,
      'color'     => 'edges'  ,
      'rotary_logo' => 'affiliation'
    }
    css_class = css_classes["#{text}"]
    url = url_for(:controller => "/customize", :action => "choose_customizable", :customizable_name => text, :id => my_badge  )
    html = link_to_remote text, 
      :url => url,  
      :before => "Element.show('indicator')",
      :complete => "Element.hide('indicator')"
    html = content_tag(:li, html, :class => css_class)
    return html
  end
  
end
