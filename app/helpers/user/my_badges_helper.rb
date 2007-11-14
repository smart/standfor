module User::MyBadgesHelper

  def  my_badge_sponsorship_option_select  
       [ ["Choose A Sponsorship Plan", "" ], ["Plan A","A"], ["Plan B","B"], ["Plan C", "C"] ]
  end

  def  my_badge_merit_option_select  
       [  ["Yes","yes"], ["No","no"] ]
  end

  def my_badge_link(my_badge, path)
  	link = link_to(image_tag("placeholders/imageselections.jpg"), path)
  	mouseover = "Element.show('#{dom_id(my_badge)}')"
  	mouseout = "Element.hide('#{dom_id(my_badge)}')"
  	meta = content_tag(:li, my_badge.badge.name)
  	meta << content_tag(:li, "Organization: " + my_badge.badge.organization.name)
  	meta << content_tag(:li, "Cause: " + my_badge.badge.segment.name)
  	meta << content_tag(:li, link_to("View this Badge", path))
  	meta = content_tag(:ul, meta)
  	meta = link_to(image_tag("placeholders/mediumbadge.jpg"), path) + meta
  	meta = content_tag(:div, meta, :class => 'badge-meta', :id => dom_id(my_badge), :style => "display:none;")
    html = content_tag(:div, meta + link, :class => 'badge-link', :onmouseover => mouseover, :onmouseout => mouseout)
    html
  end
  
end
