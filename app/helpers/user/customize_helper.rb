module User::CustomizeHelper

  def option_link(icon_class, text, my_badge)
    html = link_to_remote text, 
      :url => {:controller => "user/customize",
      :action => "choose_customizable",
      :customizable_name => text,
      :id => my_badge  },
      :before => "Element.show('indicator')",
      :complete => "Element.hide('indicator')"
    html = content_tag(:li, html, :class => icon_class)
    return html
  end
end
